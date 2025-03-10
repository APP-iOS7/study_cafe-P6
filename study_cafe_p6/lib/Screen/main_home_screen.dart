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

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return '서버에서 받아온 데이터';
}

class _MainHomeViewState extends State<MainHomeView> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
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
<<<<<<< HEAD
                      '${user?.displayName ?? "사용자"} 님의 이용권',
=======
                      '${user!.displayName}\n님의 이용권',
>>>>>>> develop
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.83,
                height: MediaQuery.of(context).size.height * 0.63,
                decoration: BoxDecoration(
                  color: const Color(0xfff8f2de),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder<ReservationInfo?>(
                  future: fetchLatestReservation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || snapshot.data == null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.ticket,
                              size: 130,
                              color: Color(0xffd84040),
                            ),
                            SizedBox(height: 50),
                            Text(
<<<<<<< HEAD
                              '이용권 구매는 상단 오른쪽의\n이용권 구매에서도 가능합니다.',
                              textAlign: TextAlign.center,
=======
                              '사용가능한 이용권이 없습니다\n이용권을 구매 해주세요.',
>>>>>>> develop
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
                                Get.to(() => SeatPageView());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xff305cde),
                                  borderRadius: BorderRadius.circular(10),
                                ),
<<<<<<< HEAD
                                child: Text(
                                  '이용권 구매',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
=======
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
>>>>>>> develop
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            '현재 예약 완료된 이용권',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(color: Colors.black45),
                          SizedBox(height: 10),
                          _reservationDetailRow(
                            "예약번호",
                            reservation.reservationId ?? "N/A",
                          ),
                          _reservationDetailRow(
                            "상품명",
                            "${reservation.serviceName} 이용권",
                          ),
                          _reservationDetailRow("좌석", reservation.seatInfo),
                          _reservationDetailRow(
                            "결제금액",
                            "${NumberFormat('#,###').format(reservation.amount!)}원",
                          ),
                          _reservationDetailRow(
                            "예약일시",
                            reservation.reservationDate.toString().split(
                              ' ',
                            )[0],
                          ),
                          // SizedBox(height: 30),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.to(() => ReservationhistoryScreen());
                          //   },
                          //   child: Container(
                          //     width: double.infinity,
                          //     height: 50,
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xff305cde),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Text(
                          //       '예약내역 보기',
                          //       style: TextStyle(
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
    );
  }

  Widget _reservationDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<ReservationInfo?> fetchLatestReservation() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }

    String uid = FirebaseAuth.instance.currentUser!.uid;
    ReservationRepository reservationRepo = ReservationRepository();
    List<ReservationInfo> reservations = await reservationRepo
        .getUserReservations(uid);

    // 가장 최근 예약 정보 가져오기 (createdAt 기준 정렬)
    reservations.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return reservations.isNotEmpty ? reservations.first : null;
  }
}
