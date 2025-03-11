import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/login/login_screen.dart';

Future<void> deleteUserAccount(BuildContext context) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    if (user == null) {
      print('[D]user null check');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('현재 로그인된 사용자가 없습니다.')));
      return;
    } else {
      // print('[D]user check');
    }

    String uid = user.uid;
    await firestore.collection('users').doc(uid).delete();
    await user.delete();

    ScaffoldMessenger.of(
      // print('[D]delete check');
      context,
    ).showSnackBar(SnackBar(content: Text('계정이 삭제되었습니다.')));

    Get.to(() => LoginScreen());
  } catch (e) {
    print('[E]deleteUserAccount() check');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('회원 탈퇴 실패: ${e.toString()}')));
  }
}
