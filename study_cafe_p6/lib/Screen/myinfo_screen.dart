import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_history_screen.dart';
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffe4d7c4),
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffe4d7c4),
                  borderRadius: BorderRadius.circular(10),
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

          SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              print("[D]비밀번호변경");
              // Get.to(() => ReservationhistoryScreen());
              passwordChangeAlert(context: context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffe4d7c4),
                  borderRadius: BorderRadius.circular(10),
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

          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("[D]회원탈퇴");
                    deleteAccountAlert(context: context);
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    loginViewModel.signOut();
                    Get.off(() => LoginScreen());
                    print("[D]로그아웃");
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFD84040),
                      borderRadius: BorderRadius.circular(10),
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
              ],
            ),
          ),
          SizedBox(height: 80),
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
