import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/Payment/payment_screen.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, required this.reservationInfo});
  final ReservationInfo reservationInfo;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late List<bool> _toggledStates;
  late ReservationInfo _updatedReservationInfo;

  @override
  void initState() {
    super.initState();
    _toggledStates = List<bool>.filled(6, false);
    _updatedReservationInfo = widget.reservationInfo;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('현재 사용자 이름: ${user.displayName}');
    }

    return Scaffold(
      appBar: AppBar(title: Text('예약하기'), backgroundColor: Color(0xfff8f2de)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 15),
                Text(user?.displayName ?? '익명', style: TextStyle(fontSize: 30)),
                SizedBox(width: 65),
                Text(
                  widget.reservationInfo.seatInfo,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final plan = ['1 시간', '2 시간', '4 시간', '6 시간', '일주일', '한 달'];
                  final price = planPrice(plan[index]);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _toggledStates[index] = !_toggledStates[index];
                          if (_toggledStates[index]) {
                            _updatedReservationInfo = ReservationInfo(
                              reservationId:
                                  widget.reservationInfo.reservationId,
                              customerName: widget.reservationInfo.customerName,
                              reservationDate:
                                  widget.reservationInfo.reservationDate,
                              seatInfo: widget.reservationInfo.seatInfo,
                              serviceName: plan[index], // 선택된 이용권 이름
                              amount: price, // 선택된 금액
                            );
                          } else {
                            // 선택 해제 시 원래 값으로 되돌리거나 기본값 설정
                            _updatedReservationInfo = widget.reservationInfo;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 60,
                        decoration: BoxDecoration(
                          color:
                              _toggledStates[index]
                                  ? Colors.yellow
                                  : Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${plan[index]} 이용권: ${formatAmount(price)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.chevron_right_rounded, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 6,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: InkWell(
                onTap: () {
                  if (_updatedReservationInfo.serviceName != null &&
                      _updatedReservationInfo.amount != null) {
                    Get.to(
                      () => PaymentScreen(
                        reservationInfo: _updatedReservationInfo,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('이용권을 선택해주세요')));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40.0,
                    right: 50,
                    left: 50,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '결제하기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int planPrice(String plan) {
  switch (plan) {
    case '1 시간':
      return 10000;
    case '2 시간':
      return 20000;
    case '4 시간':
      return 40000;
    case '6 시간':
      return 60000;
    case '일주일':
      return 1200000;
    case '한 달':
      return 4000000;
    default:
      return 0;
  }
}

String formatAmount(int amount) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(amount)}원';
}
