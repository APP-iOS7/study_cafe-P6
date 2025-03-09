import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class ReservationhistoryScreen extends StatefulWidget {
  final ReservationInfo reservationInfo;
  const ReservationhistoryScreen({super.key, required this.reservationInfo});

  @override
  State<ReservationhistoryScreen> createState() =>
      _ReservationhistoryScreenState();
}

class _ReservationhistoryScreenState extends State<ReservationhistoryScreen> {
  int selectIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;
  /*
  final String reservationId;
  final String serviceName;       // 서비스 / 상품명
  final int amount;               // 결제 금액
  final String customerName;      // 예약자 이름
  final String customerEmail;     // 예약자 이메일
  final DateTime reservationDate; // 예약 날짜
  final String additionalInfo;    // 추가 정보
  */

  //예약 내역 (테스트 데이터)
  //자리
  final List<String> testreservationData = [
    '공부다방 1004호',
    '공부다방 101호',
    '공부다방 1번 자리',
    '공부다방 102호',
    '공부다방 2번 자리',
    '공부다방 103호',
    '공부다방 3번 자리',
    '공부다방 11번 자리',
    '공부다방 2번 자리',
    '공부다방 6번 자리',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
  ];

  //날짜, 시간
  final List<String> testdateData = [
    '2024.01.28 10:04',
    '2024.03.26 10:04',
    '2024.03.29 10:04',
    '2024.03.30 14:42',
    '2024.04.01 16:31',
    '2024.04.05 17:00',
    '2024.05.06 22:55',
    '2024.06.02 11:01',
    '2024.07.04 16:07',
    '2024.12.06 22:16',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
  ];

  //결제 금액
  final List<String> testpayData = [
    '1,000원',
    '10,000원',
    '100,000원',
    '1,000,000원',
    '999,999원',
    '99,999원',
    '9,999원',
    '999원',
    '99원',
    '0원',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
    '----------',
  ];

  void onTap(int index) {
    setState(() {
      selectIndex = index;
      if (index == 0) {
        print('[D]탭바 0 홈');
      } else if (index == 1) {
        print('[D]탭바 1 좌석');
      } else if (index == 2) {
        print('[D]탭바 3 내정보');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("예약 내역 화면"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // print("[D]비밀번호 변경");
                    // Get.to(() => ReservationhistoryScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Container(
                      width: 100,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFECDCBF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${user!.displayName}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFECDCBF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                        left: 20,
                        right: 0,
                      ),
                      child: Text(
                        '구매 내역',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child:
                  testreservationData.isNotEmpty
                      ? ListView.builder(
                        itemCount: testreservationData.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: ListTile(
                              tileColor: Color(0xA0ECDCBF),
                              leading: Icon(
                                Icons.watch_later,
                                color: Colors.black,
                              ),
                              title: Text(
                                testreservationData[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                testdateData[index],
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: Text(
                                testpayData[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                print("[D] ${testreservationData[index]} 확인");
                              },
                            ),
                          );
                        },
                      )
                      : Center(
                        child: Text(
                          '예약 내역이 없습니다.',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
