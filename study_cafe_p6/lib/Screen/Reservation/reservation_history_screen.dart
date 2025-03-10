import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                  onTap: () {},
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
                    // print('[D]check uid = ${user!.uid}');
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
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: ListTile(
                          tileColor: Color(0xA0ECDCBF),
                          leading: Icon(Icons.watch_later, color: Colors.black),
                          title: Text(
                            reservation.serviceName ?? "서비스 없음",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${reservation.reservationDate.toLocal()}".split(
                              '.',
                            )[0],
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            "${reservation.amount?.toString() ?? '0'}원",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            print("[D] ${reservation.serviceName} 확인");
                          },
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
