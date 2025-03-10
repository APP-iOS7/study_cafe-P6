import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_history_screen.dart';
import 'package:study_cafe_p6/Screen/account_manager.dart';
import 'package:study_cafe_p6/Screen/alertdialog_screen.dart';
import 'package:study_cafe_p6/ViewModel/user_profile_model.dart';
import 'package:study_cafe_p6/login/login_screen.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({super.key});

  @override
  State<MyinfoScreen> createState() => _MyinfoScreenState();
}

class _MyinfoScreenState extends State<MyinfoScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  var loginViewModel = LoginViewModel();
  int selectIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 정보 화면',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xfff8f2de),
          ),
        ),
        backgroundColor: Color(0xffd84040),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundCircle(size: 130),
                SizedBox(width: 50, height: 0),
                Text(
                  '${user!.displayName}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          SizedBox(height: 100),

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
                decoration: BoxDecoration(
                  // color: Color(0xffd84040),
                  borderRadius: BorderRadius.circular(10),
                ),
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
              child: Divider(color: const Color.fromARGB(255, 200, 198, 198)),
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
                decoration: BoxDecoration(
                  // color: Color(0xffd84040),
                  borderRadius: BorderRadius.circular(10),
                ),
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
              child: Divider(color: const Color.fromARGB(255, 200, 198, 198)),
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
              child: Divider(color: const Color.fromARGB(255, 200, 198, 198)),
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
              child: Divider(color: const Color.fromARGB(255, 200, 198, 198)),
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
              child: Divider(color: const Color.fromARGB(255, 200, 198, 198)),
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
                    style: TextStyle(fontSize: 15, color: Colors.grey),
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
              child: Divider(color: const Color.fromARGB(255, 200, 198, 198)),
            ),
          ),
          SizedBox(height: 5),

          GestureDetector(
            onTap: () {
              print("[D]로그아웃");
              // Get.to(() => ReservationhistoryScreen());
              passwordChangeAlert(context: context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Color(0xffd84040),
                  borderRadius: BorderRadius.circular(10),
                ),
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
    );
  }
}

class RoundCircle extends StatefulWidget {
  final double size;
  const RoundCircle({super.key, required this.size});

  @override
  _RoundCircleState createState() => _RoundCircleState();
}

class _RoundCircleState extends State<RoundCircle> {
  String? _base64Image;
  final UserRepository _userRepo = UserRepository();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    var user = await _userRepo.getUserFromFirestore();
    if (user != null && user.profileImage != null) {
      setState(() {
        _base64Image = user.profileImage;
      });
    }
  }

  Future<void> _pickAndSaveImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    await _userRepo.updateProfileImage(base64Image);

    setState(() {
      _base64Image = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickAndSaveImage,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
          border: Border.all(color: Colors.black, width: 2),
          image:
              _base64Image != null
                  ? DecorationImage(
                    image: MemoryImage(base64Decode(_base64Image!)),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child:
            _base64Image == null
                ? Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                : null,
      ),
    );
  }
}
