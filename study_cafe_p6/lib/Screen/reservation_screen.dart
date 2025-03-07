import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/reservation_final_screen.dart';
import 'package:study_cafe_p6/login/login_screen.dart';
import 'package:study_cafe_p6/loginViewModel/login_view_model.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('현재 사용자 이름: ${user.displayName}');
    }
    var vm = LoginViewModel();

    return Scaffold(
      appBar: AppBar(title: Text('예약하기'), backgroundColor: Color(0xfff8f2de)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Text('${user!.displayName}', style: TextStyle(fontSize: 30)),
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
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ReservationFinalScreen(
                                    selectedPlan: '${plan[index]} 이용권',
                                    selectedPrice: price,
                                  ),
                            ),
                          );
                        },

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text(
                                '${plan[index]} 이용권: ${formatAmount(price)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
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
          ElevatedButton(
            onPressed: () {
              vm.signOut();
              Get.off(() => LoginScreen());
            },
            child: Text('로그아웃'),
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
