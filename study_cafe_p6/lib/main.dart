import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/reserve_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Study Cafe_Reserve', home: ReserveScreen());
  }
}
