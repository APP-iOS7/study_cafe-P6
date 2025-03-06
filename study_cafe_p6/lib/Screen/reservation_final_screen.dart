import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(title: Text('예약하기'), backgroundColor: Color(0xfff8f2de)),
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text('사용자 예약정보', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Text(
                        '선택한 이용권: $selectedPlan\n결제 금액: ${formatAmount(selectedPrice)}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('금액', style: TextStyle(fontSize: 20)),
                      Text('좌석 정보', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {},
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
