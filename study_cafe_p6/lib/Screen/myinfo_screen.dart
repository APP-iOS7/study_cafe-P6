import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';
import 'package:study_cafe_p6/main.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({super.key});

  @override
  State<MyinfoScreen> createState() => _MyinfoScreenState();
}

class _MyinfoScreenState extends State<MyinfoScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        print('[D]탭바 0 홈');
      } else if (index == 1) {
        print('[D]탭바 1 좌석');
      } else if (index == 2) {
        print('[D]탭바 3 내정보');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyinfoScreen()),
        );
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundCircle(size: 200),

            SizedBox(width: 10, height: 10),

            Text('User0123'),

            SizedBox(width: 10, height: 10),

            ElevatedButton(
              onPressed: () {
                print("[D]예약내역확인");
              },
              child: const Text('예약 내역 확인'),
            ),

            ElevatedButton(
              onPressed: () {
                print("[D]비밀번호변경");
              },
              child: const Text('비밀번호 변경'),
            ),

            ElevatedButton(
              onPressed: () {
                print("[D]로그아웃");
              },
              child: const Text('로그아웃'),
            ),

            ElevatedButton(
              onPressed: () {
                print("[D]회원탈퇴");
              },
              child: const Text('회원탈퇴'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class RoundCircle extends StatelessWidget {
  final double size;
  final ImageProvider? image;

  const RoundCircle({required this.size, this.image});

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
