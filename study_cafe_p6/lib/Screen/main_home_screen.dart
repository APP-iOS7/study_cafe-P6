import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_history_screen.dart';
import 'package:study_cafe_p6/Screen/seat_page_screen.dart';
import 'package:study_cafe_p6/ViewModel/reservation_history_model.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 20,
                        bottom: 20,
                      ),
                      child: Text(
                        '${user!.displayName}\n님의 이용권',
                        style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.83,
                  height: MediaQuery.of(context).size.height * 0.62,
                  decoration: BoxDecoration(
                    color: const Color(0xfff8f2de),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(35, 0, 0, 0), // 그림자 색상
                        offset: Offset(4, 4), // 그림자 위치 (오른쪽 아래로 4px)
                        blurRadius: 10, // 흐림 정도
                        spreadRadius: 2, // 확산 정도
                      ),
                    ],
                  ),

                  child: FutureBuilder<ReservationInfo?>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("에러 발생");
                      }

                      if (snapshot.data == null) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 130),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.tickets,
                                size: 130,
                                color: Color(0xffd84040),
                              ),
                              SizedBox(height: 50),
                              Text(
                                '사용가능한 이용권이 없습니다\n이용권을 구매 해주세요.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff777777),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 50),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => SeatPageView(isFromHome: true));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 50,
                                    right: 50,
                                    top: 20,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xffd84040),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '이용권 구매',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      ReservationInfo reservation = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  CupertinoIcons.tickets_fill,
                                  color: Color(0xffd84040),
                                  size: 40,
                                ),
                                Text(
                                  '사용가능 이용권',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(
                              color: const Color.fromARGB(255, 212, 212, 212),
                              height: 0.5,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("예약번호 :", style: TextStyle(fontSize: 18)),
                                Text(
                                  reservation.reservationId ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("상품명 :", style: TextStyle(fontSize: 18)),
                                Text(
                                  "${reservation.serviceName} 이용권",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("좌석 :", style: TextStyle(fontSize: 18)),
                                Text(
                                  reservation.seatInfo,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("결제금액 :", style: TextStyle(fontSize: 18)),
                                Text(
                                  "${NumberFormat('#,###').format(reservation.amount!)}원",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xffd84040),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("예약일시 :", style: TextStyle(fontSize: 18)),
                                Text(
                                  reservation.reservationDate.toString().split(
                                    ' ',
                                  )[0],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 130),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ReservationhistoryScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                  right: 50,
                                  top: 20,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd84040),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '예약내역 보기',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ReservationInfo?> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final reservations = await ReservationRepository().getUserReservations(
      user.uid,
    );
    if (reservations.isEmpty) return null;

    return reservations.reduce(
      (a, b) => a.createdAt.isAfter(b.createdAt) ? a : b,
    );
  }
}
