import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/login/login_screen.dart';

//정리 시 이동 예정
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

Future<void> deleteAccountalert({
  required BuildContext context,
  String title = '알림',
  String content = '\'공부다방\' 탈퇴하시겠습니까?',
}) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(content, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              deleteUserAccount(context);
            },
            child: Text(
              '확인',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              '취소',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
