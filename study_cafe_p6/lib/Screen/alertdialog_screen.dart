import 'package:flutter/material.dart';
import 'package:study_cafe_p6/ViewModel/user_delete_model.dart';
import 'package:study_cafe_p6/ViewModel/user_password_change_model.dart';

Future<void> passwordChangeAlert({
  required BuildContext context,
  String title = '비밀번호 변경',
  String content = '비밀번호 변경 창이지롱',
}) {
  final UserPasswordChangeModel passwordModel = UserPasswordChangeModel();

  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title, textAlign: TextAlign.center),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(content, textAlign: TextAlign.center),
            SizedBox(height: 10),
            TextField(
              controller: passwordModel.newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '새 비밀번호'),
            ),
          ],
        ),

        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.of(dialogContext).pop();
              passwordModel.updatePassword(dialogContext);
              //여기 수정하면 될 듯 이어서 진행 예정.
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
            onPressed: () {
              Navigator.of(dialogContext).pop();
              //여기 수정하면 될 듯 이어서 진행 예정.
            },
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
  ).then((_) => passwordModel.dispose());
}

Future<void> deleteAccountAlert({
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
