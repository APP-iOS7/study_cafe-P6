import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/alertdialog_screen.dart';

class AccountManager extends StatelessWidget {
  const AccountManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('계정 관리')),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              print("[D]비밀번호변경");
              // Get.to(() => ReservationhistoryScreen());
              passwordChangeAlert(context: context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Color(0xffd84040),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '비밀번호 변경',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 30),
                  ],
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              print("[D]회원탈퇴");
              deleteAccountAlert(context: context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Color(0xffd84040),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '계정삭제',
                      style: TextStyle(
                        color: Color(0xffd84040),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: Color(0xffd84040),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
