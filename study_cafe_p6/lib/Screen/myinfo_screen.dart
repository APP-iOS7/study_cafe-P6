// ignore_for_file: unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_history_screen.dart';
import 'package:study_cafe_p6/Screen/account_manager.dart';
import 'package:study_cafe_p6/Screen/login/login_screen.dart';
import 'package:study_cafe_p6/ViewModel/auth_view_model.dart';
import 'package:study_cafe_p6/ViewModel/login_view_model.dart';
import 'package:study_cafe_p6/round_circle.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({super.key});

  @override
  State<MyinfoScreen> createState() => _MyinfoScreenState();
}

class _MyinfoScreenState extends State<MyinfoScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authViewModel = Get.find<AuthViewModel>();

  var loginViewModel = LoginViewModel();
  int selectIndex = 2;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffd84040),
          title: Text(
            '내 정보',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                  left: 30,
                  right: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundCircle(size: 130),
                    FutureBuilder<String>(
                      future: _authViewModel.getUserName(),
                      builder: (context, usernameSnapshot) {
                        if (usernameSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            '로딩중...\n',
                            style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        final username = usernameSnapshot.data ?? '정보없음';
                        return Text(
                          username,
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '예약 내역 확인',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 30),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Divider(
                    color: const Color.fromARGB(255, 200, 198, 198),
                  ),
                ),
              ),
              SizedBox(height: 5),

              GestureDetector(
                onTap: () {
                  Get.to(() => AccountManager());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '계정 관리',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 30),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Divider(
                    color: const Color.fromARGB(255, 200, 198, 198),
                  ),
                ),
              ),
              SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "고객센터",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Divider(
                    color: const Color.fromARGB(255, 200, 198, 198),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "이용약관",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Divider(
                    color: const Color.fromARGB(255, 200, 198, 198),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "개인 정보 처리방침",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Divider(
                    color: const Color.fromARGB(255, 200, 198, 198),
                  ),
                ),
              ),
              SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "버전 정보",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '1.0.1',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: Divider(
                    color: const Color.fromARGB(255, 200, 198, 198),
                  ),
                ),
              ),
              SizedBox(height: 5),

              GestureDetector(
                onTap: () {
                  print("[D]로그아웃");
                  // Get.to(() => ReservationhistoryScreen());
                  loginViewModel.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.logout,
                            size: 30,
                            color: Color(0xffd84040),
                          ),
                        ),
                        Text(
                          '로그아웃',
                          style: TextStyle(
                            color: Color(0xffd84040),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
