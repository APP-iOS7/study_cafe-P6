import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/reservation_screen.dart';
import 'package:study_cafe_p6/Screen/text_field.dart';
import 'package:study_cafe_p6/login/login_screen.dart';
import 'package:study_cafe_p6/model/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Firebase Auth 초기화
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 회원가입 함수
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );

        await userCredential.user?.updateDisplayName(
          _usernameController.text.trim(),
        );

        await userCredential.user?.reload();
        User? updatedUser = FirebaseAuth.instance.currentUser;

        UserModel user = UserModel(
          username: _usernameController.text,
          useremail: _emailController.text,
          uid: userCredential.user!.uid,
        );
        // 회원가입 성공 후 Firestore에 사용자 정보 저장
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': user.username,
          'email': user.useremail,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입 성공! 이름:${updatedUser?.displayName}')),
        );
        Get.off(() => ReservationScreen());
      } catch (e) {
        debugPrint('$e');
        setState(() {
          _isLoading = false; // 로딩완료
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('회원가입 실패')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f2de),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로고 이미지
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SignUpUserNameTextField(
                            usernameController: _usernameController,
                          ),
                        ),
                        SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SignUpEmailTextField(
                            emailController: _emailController,
                          ),
                        ),
                        SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SignUpPasswordTextField(
                            passwordController: _passwordController,
                          ),
                        ),
                        SizedBox(height: 20),
                        _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Padding(padding: const EdgeInsets.all(15)),

                        GestureDetector(
                          onTap: _signUp,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 20,
                              right: 20,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 58,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xffa31d1d),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '이미 회원이세요?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.off(() => LoginScreen());
                              },
                              child: Text(
                                '로그인',
                                style: TextStyle(
                                  color: Color(0xffa31d1d),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
