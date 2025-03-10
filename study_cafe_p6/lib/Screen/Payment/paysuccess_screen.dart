import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_history_screen.dart';
import 'package:study_cafe_p6/Screen/tabbar_screen.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class PaySuccess extends StatelessWidget {
  const PaySuccess({super.key, required this.reservationInfo});

  final ReservationInfo reservationInfo;

  // Format amount with commas
  String formatAmount(int amount) {
    final formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column이 최소 크기로 조정되도록 설정
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(30, 0, 0, 0), // 그림자 색상
                      offset: Offset(4, 4), // 그림자 위치 (오른쪽 아래로 4px)
                      blurRadius: 10, // 흐림 정도
                      spreadRadius: 2, // 확산 정도
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 80),
                    SizedBox(height: 20),
                    Text(
                      '결제가 완료되었습니다.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    '결제정보',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
              Divider(color: const Color.fromARGB(255, 214, 214, 214)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '예약번호',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    '${reservationInfo.reservationId}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '상품명',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    '${reservationInfo.serviceName} 이용권',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '좌석',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    reservationInfo.seatInfo,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '결제금액',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    '${formatAmount(reservationInfo.amount!)}원',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '예약일시',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Text(
                    reservationInfo.reservationDate.toString().split(' ')[0],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  Get.to(() => ReservationhistoryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xffaaaaaa),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '예약내역 보기',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.off(() => BottomTabBar());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xffd84040),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '홈으로 돌아가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
