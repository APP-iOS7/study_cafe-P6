import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:study_cafe_p6/Screen/Notification/noti_service.dart';
import 'package:study_cafe_p6/Screen/splash_screen.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';
import 'package:get/route_manager.dart';
import 'package:study_cafe_p6/ViewModel/login_view_model.dart';
import 'package:study_cafe_p6/ViewModel/round_circle_view_model.dart';
import 'package:study_cafe_p6/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotiService().initNotification();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  KakaoSdk.init(
    nativeAppKey: 'e66072d11dd5b4fe1b7b37d6ebe50885',
    javaScriptAppKey: '9bd21100e83fd3d8142f4818af42fde7',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RoundCircleViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Cafe_Reserve',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return BottomTabBar();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
