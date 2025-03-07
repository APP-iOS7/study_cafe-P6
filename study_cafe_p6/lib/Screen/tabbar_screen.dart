import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/myinfo_screen.dart';
import 'package:study_cafe_p6/view/main_home_view.dart';
import 'package:study_cafe_p6/view/seat_page_view.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [MainHomeView(), SeatPageView(), MyinfoScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.chair), label: '좌석'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보'),
        ],
      ),
    );
  }
}
