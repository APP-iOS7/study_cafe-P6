import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/ViewModel/auth_view_model.dart';
import 'package:study_cafe_p6/ViewModel/reservation_history_model.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class ReservationhistoryScreen extends StatefulWidget {
  const ReservationhistoryScreen({super.key});

  @override
  State<ReservationhistoryScreen> createState() =>
      _ReservationhistoryScreenState();
}

class _ReservationhistoryScreenState extends State<ReservationhistoryScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ReservationRepository _reservationRepo = ReservationRepository();
  final _authViewModel = Get.put(AuthViewModel());
  double borderRadius = 5;

  String formatAmount(int amount) {
    final formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "예약 내역 화면",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffd84040),
        scrolledUnderElevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 20,
                      right: 0,
                    ),
                    child: FutureBuilder<String>(
                      future: _authViewModel.getUserName(),
                      builder: (context, usernameSnapshot) {
                        if (usernameSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            '로딩중...\n',
                            style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        final username = usernameSnapshot.data ?? '정보없음';
                        return Text(
                          '$username 님의 \n예약 내역',
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: FutureBuilder<List<ReservationInfo>>(
                future:
                    user != null
                        ? _reservationRepo.getUserReservations(user!.uid)
                        : null,
                builder: (context, snapshot) {
                  // print("[D]snapshot.connectionState = ${snapshot.connectionState}");
                  // print("[D]snapshot.data = ${snapshot.data}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('[E]${snapshot.error}');
                    return Center(child: Text("오류 : ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        '예약 내역이 없습니다.',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    );
                  }

                  final reservations = snapshot.data!;

                  return ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];
                      return SizedBox(
                        height: 85,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                          child: ListTile(
                            tileColor: Color(0x77ECDCBF),
                            leading: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Icon(
                                Icons.watch_later,
                                color: Colors.black,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${reservation.reservationDate.toLocal()}'
                                      .split(' ')[0],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '좌석 번호 : ${reservation.seatInfo}, 이용권 : ${reservation.serviceName}' ??
                                      '서비스 없음',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${formatAmount(reservation.amount!)}원',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffd84040),
                                ),
                              ),
                            ),
                            onTap: () {
                              print('[D] ${reservation.serviceName} 확인');
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
