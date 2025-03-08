import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/reservation_screen.dart';
import 'package:flutter/cupertino.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return '서버에서 받아온 데이터';
}

class _MainHomeViewState extends State<MainHomeView> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인페이지'),
        backgroundColor: Color.fromRGBO(234, 225, 201, 1),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    '${user!.displayName}님의 이용권',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => ReservationScreen());
                    },
                    icon: Icon(Icons.local_activity),
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.ticket),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 270),
              child: Text('이용권 구매'),
            ),
            Container(
              width: 400,
              height: 522,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('에러 발생'));
                  }
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return Center(child: Text('예약 정보 표시'));
                  }
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
