import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/reserve_screen.dart';
import 'package:study_cafe_p6/login/signup_screen.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var vm = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F2DE),
      body: SafeArea(
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
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Email',
                    ),
                    controller: vm.emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Password',
                    ),
                    controller: vm.pwController,
                  ),
                ),
                SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Get.to(() => ReserveScreen());
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
        ),
      ),
    );
  }
}
