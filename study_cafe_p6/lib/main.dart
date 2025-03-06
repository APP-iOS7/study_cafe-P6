import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/reservation_final_screen.dart';
import 'package:study_cafe_p6/Screen/reservation_screen.dart';
import 'package:get/route_manager.dart';
import 'package:study_cafe_p6/Screen/reserve_screen.dart';
import 'package:study_cafe_p6/firebase_options.dart';
import 'package:study_cafe_p6/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Study Cafe_Reserve', home: ReservationScreen());
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
            return ReserveScreen();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
