import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPwPage extends StatefulWidget {
  const ResetPwPage({super.key});

  @override
  State<ResetPwPage> createState() => _ResetPwPageState();
}

class _ResetPwPageState extends State<ResetPwPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              '비밀번호 재설정 링크가 발송 되었습니다. 이메일을 확인해주세요.',
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('유효한 이메일을 입력해주세요.', textAlign: TextAlign.center),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffd84040),
        foregroundColor: Colors.white,
        title: Text('비밀번호 찾기', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text('비밀번호를 잊어버리셨나요?', style: TextStyle(fontSize: 25)),
            ),
            SizedBox(height: 10),
            Text(
              '공부다방에 가입했던 이메일을 입력해주세요. \n 비밀번호 재설정 메일을 보내드립니다.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: passwordReset,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffd84040),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 57,
                  child: Text(
                    '비밀번호 재설정',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
