import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/myinfo_screen.dart';
import 'package:study_cafe_p6/Screen/reservation_final_screen.dart';
import 'package:study_cafe_p6/Screen/reservation_screen.dart';
import 'package:study_cafe_p6/view/main_home_view.dart';
import 'package:study_cafe_p6/view/seat_page_view.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    MainHomeView(),
    SeatPageView(),
    MyinfoScreen(),
    ReservationScreen(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [MainHomeView(), SeatPageView(), MyinfoScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        selectedItemColor: Color(0xffd84040),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: _selectedTabItem(Icons.home_outlined, '홈', 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedTabItem(Icons.chair_outlined, '좌석현황', 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedTabItem(Icons.person_outline, '내 정보', 2),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _selectedTabItem(
    IconData icon,
    String label,
    int index, {
    bool isActive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: _selectedIndex == index ? Color(0xffd84040) : Colors.grey,
          size: 30,
        ),
        Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index ? Color(0xffd84040) : Colors.grey,
          ),
        ),
        SizedBox(height: 4),
        if (_selectedIndex == index)
          Container(width: 50, height: 3, color: Color(0xffd84040))
        else
          SizedBox(height: 2),
      ],
    );
  }
}
