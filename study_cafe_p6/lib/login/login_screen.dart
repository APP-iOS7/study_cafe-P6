import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/text_field.dart';
import 'package:study_cafe_p6/login/signup_screen.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var vm = LoginViewModel();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F2DE),
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
                          child: EmailTextField(vm: vm),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: PasswordTextField(vm: vm),
                        ),
                        SizedBox(height: 20),

                        GestureDetector(
                          onTap: vm.signIn,
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
                                '로그인',
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
                              '회원이 아니신가요?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => SignupScreen());
                              },
                              child: Text(
                                '회원가입',
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
