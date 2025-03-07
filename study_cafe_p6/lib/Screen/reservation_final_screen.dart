import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/payment_screen.dart';

class ReservationFinalScreen extends StatelessWidget {
  const ReservationFinalScreen({
    super.key,
    required this.selectedPlan,
    required this.selectedPrice,
  });

  final String selectedPlan;
  final int selectedPrice;

  String formatAmount(int amount) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(amount)}원';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 예약정보'),
        backgroundColor: Color(0xfff8f2de),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Text(
                          '선택한 이용권: $selectedPlan',
                          style: TextStyle(fontSize: 25),
                          softWrap: true,
                        ),
                        SizedBox(height: 20),
                        Text(
                          '결제 금액: ${formatAmount(selectedPrice)}',
                          style: TextStyle(fontSize: 25),
                          softWrap: true,
                        ),
                        SizedBox(height: 20),
                        Text('좌석 정보', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Get.to(() => PaymentScreen(selectedPrice: selectedPrice));
                },
                child: Container(
                  width: 250,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text('결제하기', style: TextStyle(fontSize: 30)),
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
