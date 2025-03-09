import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservationhistory_screen.dart';
import 'package:study_cafe_p6/login/login_screen.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({super.key});

  @override
  State<MyinfoScreen> createState() => _MyinfoScreenState();
}

class _MyinfoScreenState extends State<MyinfoScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  var vm = LoginViewModel();
  int selectIndex = 2;

  void onTap(int index) {
    setState(() {
      selectIndex = index;
      if (index == 0) {
        print('[D]탭바 0 홈');
        // Get.to(() => HomeScreen());
      } else if (index == 1) {
        print('[D]탭바 1 좌석');
      } else if (index == 2) {
        print('[D]탭바 3 내정보');
        Get.to(() => MyinfoScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 정보 화면"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundCircle(size: 100),
                  SizedBox(width: 50, height: 0),
                  Text(
                    '${user!.displayName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50),

            GestureDetector(
              onTap: () {
                print("[D]예약내역확인");
                Get.to(() => ReservationhistoryScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFECDCBF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '예약 내역 확인',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                print("[D]비밀번호변경");
                // Get.to(() => ReservationhistoryScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFECDCBF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '비밀번호 변경',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                vm.signOut();
                Get.off(() => LoginScreen());
                print("[D]로그아웃");
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFD84040),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                print("[D]회원탈퇴");
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFD84040),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '회원 탈퇴',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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

class RoundCircle extends StatelessWidget {
  final double size;
  final ImageProvider? image;

  const RoundCircle({super.key, required this.size, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        border: Border.all(color: Colors.black, width: 2),
        image:
            image != null
                ? DecorationImage(image: image!, fit: BoxFit.cover)
                : null,
      ),
    );
  }
}
