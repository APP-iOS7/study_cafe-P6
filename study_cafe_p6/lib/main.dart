import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/myInfo_screen.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Cafe_Reserve',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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
        title: const Text("임시 홈 화면"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyinfoScreen()),
              );
            },
            child: const Text("내 정보 화면"),
          ),
        ),
      ),
      bottomNavigationBar: BottomTabBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
