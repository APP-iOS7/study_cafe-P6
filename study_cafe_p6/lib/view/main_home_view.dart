import 'package:flutter/material.dart';
import '../model/reserve_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인페이지'),
        backgroundColor: Color.fromRGBO(234, 225, 201, 1),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('  @@@님의 ID'),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.local_activity),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: Text('이용권 구매'),
            ),
            Container(
              width: 400,
              height: 650,
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
