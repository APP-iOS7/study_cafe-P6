import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('[D]${e}');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('비밀번호 변경 실패: ${e.toString()}')));
    }
  }

  void dispose() {
    newPasswordController.dispose();
  }
}
