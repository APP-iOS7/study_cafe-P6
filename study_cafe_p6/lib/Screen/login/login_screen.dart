import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_cafe_p6/Screen/Login/kakao_login.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';
import 'package:study_cafe_p6/Screen/text_field.dart';
import 'package:study_cafe_p6/Screen/login/signup_screen.dart';
import 'package:study_cafe_p6/ViewModel/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: Color(0xFFF8F2DE),
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 로고 이미지
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Form(
                        key: _formKey,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: LoginEmailTextField(
                                emailController: emailController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: LoginPasswordTextField(
                                pwController: pwController,
                              ),
                            ),
                            SizedBox(height: 20),
                            viewModel.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Padding(padding: const EdgeInsets.all(15)),

                            GestureDetector(
                              onTap:
                                  viewModel.isLoading
                                      ? null
                                      : () async {
                                        if (_formKey.currentState!.validate()) {
                                          bool success = await viewModel.signIn(
                                            emailController.text,
                                            pwController.text,
                                          );
                                          if (success) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text('로그인 성공')),
                                            );
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => BottomTabBar(),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text('로그인 실패')),
                                            );
                                          }
                                        }
                                      },
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
                                    color: Color(0xffd84040),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    '로그인',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
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
                                  '회원이 아니신가요?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '회원가입',
                                    style: TextStyle(
                                      color: Color(0xffd84040),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'or 카카오 로그인',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: 35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    kakaoLogin();
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFEE500),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/kakao.png',
                                          height: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text('카카오 로그인', style: TextStyle()),
                                      ],
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
            );
          },
        ),
      ),
    );
  }
}
