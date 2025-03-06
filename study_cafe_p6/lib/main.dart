import 'package:flutter/material.dart';
import 'package:study_cafe_p6/main_home_view.dart';
import 'package:study_cafe_p6/seat_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SeatPageView(),
    );
  }
}
