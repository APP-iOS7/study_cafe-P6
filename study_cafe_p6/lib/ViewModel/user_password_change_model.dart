import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/login/login_screen.dart';

class UserPasswordChangeModel {
  final TextEditingController newPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updatePassword(BuildContext context) async {
    try {
      String newPassword = newPasswordController.text.trim();
      if (newPassword.isEmpty || newPassword.length < 6) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('비밀번호는 6자 이상이어야 합니다.')));
        return;
      }

      User? user = _auth.currentUser;
      if (user != null) {
        // print('[D]user : ${user.email}');
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('비밀번호가 변경되었습니다.')));
        // print('[D]check 1');
        // Navigator.of(context).pop();
        // print('[D]check 2');
        // Get.to(() => LoginScreen());
        // print('[D]check 3');
        Navigator.of(context).pop();
        // print('[D]check 4');
        Get.to(() => LoginScreen());
        // print('[D]check 5');
      }
    } catch (e) {
      print('[D]${e}');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('비밀번호 변경 실패: ${e.toString()}')));
      Navigator.of(context).pop();
    }
  }

  void dispose() {
    newPasswordController.dispose();
  }
}
