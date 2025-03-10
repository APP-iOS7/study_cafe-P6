import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/main_home_screen.dart';
import 'package:study_cafe_p6/Screen/myinfo_screen.dart';
import 'package:study_cafe_p6/Screen/seat_page_screen.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  final List<Widget> _pages = [MainHomeView(), SeatPageView(), MyinfoScreen()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(80),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: BottomNavigationBar(
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
          size: 24,
        ),
        Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index ? Color(0xffd84040) : Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        if (_selectedIndex == index)
          Container(width: 45, height: 2, color: Color(0xffd84040))
        else
          SizedBox(height: 2),
      ],
    );
  }
}
