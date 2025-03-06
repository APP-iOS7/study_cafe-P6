import 'package:flutter/material.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';

class ReservationhistoryScreen extends StatefulWidget {
  const ReservationhistoryScreen({super.key});

  @override
  State<ReservationhistoryScreen> createState() =>
      _ReservationhistoryScreenState();
}

class _ReservationhistoryScreenState extends State<ReservationhistoryScreen> {
  int selectIndex = 0;

  //예약 내역 (더미데이터)
  final List<String> reservationData = [
    '자리 위치 - 날짜 시간',
    '스터디카페 101호 - 2024.03.01 09:00',
    '스터디카페 1번 자리 - 2024.03.02 11:00',
    '스터디카페 102호 - 2024.03.03 14:00',
    '스터디카페 2번 자리 - 2024.03.04 16:00',
    '스터디카페 103호 - 2024.03.05 17:00',
    '스터디카페 3번 자리 - 2024.03.06 22:00',
    '스터디카페 1번 자리 - 2024.03.02 11:00',
    '스터디카페 2번 자리 - 2024.03.04 16:00',
    '스터디카페 3번 자리 - 2024.03.06 22:00',
    '스터디카페 1번 자리 - 2024.03.02 11:00',
    '스터디카페 2번 자리 - 2024.03.04 16:00',
    '스터디카페 3번 자리 - 2024.03.06 22:00',
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
                    print("[D]비밀번호 변경");
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
                        'User0123',
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

            SizedBox(height: 10),

            Expanded(
              child:
                  reservationData.isNotEmpty
                      ? ListView.builder(
                        itemCount: reservationData.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.watch_later,
                                color: Colors.black,
                              ),
                              title: Text(reservationData[index]),
                              onTap: () {
                                print("[D] ${reservationData[index]} 확인");
                              },
                            ),
                          );
                        },
                      )
                      : Center(
                        child: Text(
                          '예약 내역이 없습니다.',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabBar(selectedIndex: 0, onItemTapped: onTap),
    );
  }
}
