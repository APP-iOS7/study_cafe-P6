import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _gongAnimation; // 공
  late Animation<Offset> _buAnimation; // 부
  late Animation<Offset> _bangAnimation; // 방
  late Animation<Offset> _daAnimation; // 다

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // 화면 크기 기반으로 시작 위치 계산
    final startOffset = 3.0; // 화면의 50% 지점에서 시작

    // 공: 위쪽에서 시작 (y: -startOffset → 0)
    _gongAnimation = Tween<Offset>(
      begin: Offset(startOffset, 0), // 위쪽 덕
      end: Offset(0, 0), // 원래 위치
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 부: 왼쪽에서 시작 (x: -startOffset → 0)
    _buAnimation = Tween<Offset>(
      begin: Offset(0, startOffset), // 왼쪽 영
      end: Offset(0, 0), // 원래 위치
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 방: 아래쪽에서 시작 (y: startOffset → 0)
    _bangAnimation = Tween<Offset>(
      begin: Offset(-startOffset, 0), // 아래쪽 태
      end: Offset(0, 0), // 원래 위치
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 다: 오른쪽에서 시작 (x: startOffset → 0)
    _daAnimation = Tween<Offset>(
      begin: Offset(0, -startOffset), // 오른쪽 건
      end: Offset(0, 0), // 원래 위치
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // 애니메이션 시작
    _controller.forward();

    // 애니메이션 완료 후 다음 화면으로 이동
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () {
          FlutterNativeSplash.remove();
          Get.off(() => LoginScreen());
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F2DE),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 공
            SlideTransition(
              position: _gongAnimation,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 80,
                  right: 50,
                ), // 아래 여백 추가
                child: Text(
                  '덕',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'EBS Hunminjeongeum',
                  ),
                ),
              ),
            ),
            // 부
            SlideTransition(
              position: _buAnimation,
              child: Padding(
                padding: const EdgeInsets.only(left: 80, bottom: 80), // 간격 조정
                child: Text(
                  '영',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'EBS Hunminjeongeum',
                  ),
                ),
              ),
            ),
            // 방
            SlideTransition(
              position: _daAnimation,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  bottom: 50,
                  right: 50,
                ), // 간격 조정
                child: Text(
                  '태',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'EBS Hunminjeongeum',
                  ),
                ),
              ),
            ),
            // 다
            SlideTransition(
              position: _bangAnimation,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  left: 80,
                  bottom: 50,
                ), // 간격 조정
                child: Text(
                  '건',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'EBS Hunminjeongeum',
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
