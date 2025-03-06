import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';

class ReservationhistoryScreen extends StatefulWidget {
  const ReservationhistoryScreen({super.key});

  @override
  State<ReservationhistoryScreen> createState() =>
      _ReservationhistoryScreenState();
}

class _ReservationhistoryScreenState extends State<ReservationhistoryScreen> {
  int selectIndex = 0;

  void onTap(int index) {
    setState(() {
      selectIndex = index;
      if (index == 0) {
        print('[D]탭바 0 홈');
      } else if (index == 1) {
        print('[D]탭바 1 좌석');
      } else if (index == 2) {
        print('[D]탭바 3 내정보');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("예약 내역 화면"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(child: Text('User0123')),
              ),
            ),
            SizedBox(height: 100),
            Text('예약 내역이 없습니다.'),
            Text('예약 내역.'),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(selectedIndex: 0, onItemTapped: onTap),
    );
  }
}
