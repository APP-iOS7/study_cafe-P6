import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/Payment/payment_screen.dart';
import 'package:study_cafe_p6/ViewModel/auth_view_model.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, required this.reservationInfo});
  final ReservationInfo reservationInfo;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late List<bool> _toggledStates;

  @override
  void initState() {
    super.initState();
    _toggledStates = List<bool>.filled(6, false);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final authViewModel = Get.put(AuthViewModel());
    if (user != null) {
      print('현재 사용자 이름: ${user.displayName}');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Color(0xffd84040),
        title: Text(
          '예약하기',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<String>(
                  future: authViewModel.getUserName(),
                  builder: (context, usernameSnapshot) {
                    final username = usernameSnapshot.data ?? '정보없음';
                    return Text(
                      username,
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                Text(
                  '좌석: ${widget.reservationInfo.seatInfo}',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  widget.reservationInfo.reservationDate.toString().split(
                    ' ',
                  )[0],
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final plan = ['1 시간', '2 시간', '4 시간', '6 시간', '7 일', '30 일'];
                final price = planPrice(plan[index]);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0), // 오타 수정 필요
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggledStates = List<bool>.filled(6, false);
                        _toggledStates[index] = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 60,
                      decoration: BoxDecoration(
                        color:
                            _toggledStates[index]
                                ? Color(0xffd84040)
                                : Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${plan[index]} 이용권',
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    _toggledStates[index]
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            Text(
                              formatAmount(price),
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    _toggledStates[index]
                                        ? Colors.white
                                        : Color(0xffd84040),

                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: InkWell(
                onTap: () async {
                  int selectedIndex = _toggledStates.indexOf(true);
                  //이용권 선택시 버튼 활성화
                  if (selectedIndex != -1) {
                    final plan = [
                      '1 시간',
                      '2 시간',
                      '4 시간',
                      '6 시간',
                      '7 일',
                      '30 일',
                    ];
                    final selectedPlan = plan[selectedIndex];
                    final selectedPrice = planPrice(selectedPlan);

                    // 새로운 ReservationInfo 객체 생성
                    final updatedReservationInfo = ReservationInfo(
                      reservationId:
                          'rsv${DateTime.now().millisecondsSinceEpoch}',
                      amount: selectedPrice,
                      serviceName: selectedPlan,
                      // 사용자 이름 가져오기//카카오 닉네임
                      customerName: await authViewModel.getUserName(),
                      uid: user?.uid,
                      seatInfo: widget.reservationInfo.seatInfo,
                      reservationDate: widget.reservationInfo.reservationDate,
                    );

                    Get.to(
                      () => PaymentScreen(
                        reservationInfo: updatedReservationInfo,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('이용권을 선택해주세요')));
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        _toggledStates.contains(true)
                            ? Color(0xffd84040)
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
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
    case '7 일':
      return 1200000;
    case '30 일':
      return 4000000;
    default:
      return 0;
  }
}

String formatAmount(int amount) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(amount)}원';
}
