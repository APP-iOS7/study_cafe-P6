import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/login/login_screen.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class ReserveScreen extends StatelessWidget {
  const ReserveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = LoginViewModel();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            vm.signOut();
            Get.off(() => LoginScreen());
          },
          child: Text('로그아웃'),
        ),
      ),
    );
  }
}
