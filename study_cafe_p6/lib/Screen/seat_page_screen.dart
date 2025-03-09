import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_screen.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeatPageView extends StatefulWidget {
  const SeatPageView({super.key});

  @override
  State<SeatPageView> createState() => _SeatPageViewState();
}

class _SeatPageViewState extends State<SeatPageView> {
  DateTime date = DateTime.now();

  final List<Map<String, dynamic>> seats = [
    // 집중존
    {'top': 8, 'left': 10, 'isReserved': false, 'seatNumber': 'A1'},
    {'top': 8, 'left': 60, 'isReserved': false, 'seatNumber': 'A2'},
    {'top': 68, 'left': 10, 'isReserved': false, 'seatNumber': 'A3'},
    {'top': 68, 'left': 60, 'isReserved': false, 'seatNumber': 'A4'},
    {'top': 8, 'left': 110, 'isReserved': false, 'seatNumber': 'A5'},
    {'top': 68, 'left': 110, 'isReserved': false, 'seatNumber': 'A6'},
    {'top': 128, 'left': 10, 'isReserved': false, 'seatNumber': 'A7'},
    {'top': 128, 'left': 60, 'isReserved': false, 'seatNumber': 'A8'},
    {'top': 128, 'left': 110, 'isReserved': false, 'seatNumber': 'A9'},
    {'top': 188, 'left': 10, 'isReserved': false, 'seatNumber': 'A10'},
    {'top': 188, 'left': 60, 'isReserved': false, 'seatNumber': 'A11'},
    {'top': 188, 'left': 110, 'isReserved': false, 'seatNumber': 'A12'},

    // 노트북존
    {'top': 10, 'left': 200, 'isReserved': false, 'seatNumber': 'B1'},
    {'top': 10, 'left': 250, 'isReserved': false, 'seatNumber': 'B2'},
    {'top': 10, 'left': 300, 'isReserved': false, 'seatNumber': 'B3'},
    {'top': 70, 'left': 200, 'isReserved': false, 'seatNumber': 'B4'},
    {'top': 70, 'left': 250, 'isReserved': false, 'seatNumber': 'B5'},
    {'top': 70, 'left': 300, 'isReserved': false, 'seatNumber': 'B6'},
    {'top': 130, 'left': 200, 'isReserved': false, 'seatNumber': 'B7'},
    {'top': 130, 'left': 250, 'isReserved': false, 'seatNumber': 'B8'},
    {'top': 130, 'left': 300, 'isReserved': false, 'seatNumber': 'B9'},
    {'top': 190, 'left': 200, 'isReserved': false, 'seatNumber': 'B10'},
    {'top': 190, 'left': 250, 'isReserved': false, 'seatNumber': 'B11'},
    {'top': 190, 'left': 300, 'isReserved': false, 'seatNumber': 'B12'},

    // 스터디룸 (4인)
    {'top': 270, 'left': 10, 'isReserved': false, 'seatNumber': 'C1'},
    {'top': 270, 'left': 60, 'isReserved': false, 'seatNumber': 'C2'},
    {'top': 330, 'left': 10, 'isReserved': false, 'seatNumber': 'C3'},
    {'top': 330, 'left': 60, 'isReserved': false, 'seatNumber': 'C4'},

    // 스터디룸 (6인)
    {'top': 270, 'left': 130, 'isReserved': false, 'seatNumber': 'E1'},
    {'top': 270, 'left': 180, 'isReserved': false, 'seatNumber': 'E2'},
    {'top': 270, 'left': 230, 'isReserved': false, 'seatNumber': 'E3'},
    {'top': 330, 'left': 130, 'isReserved': false, 'seatNumber': 'E4'},
    {'top': 330, 'left': 180, 'isReserved': false, 'seatNumber': 'E5'},
    {'top': 330, 'left': 230, 'isReserved': false, 'seatNumber': 'E6'},
  ];

  static Map<DateTime, List<Map<String, dynamic>>> reservationDate = {};

  List<Map<String, dynamic>> changeSeats(DateTime selectedDate) {
    DateTime newSeatDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    if (!reservationDate.containsKey(newSeatDate)) {
      reservationDate[newSeatDate] =
          seats.map((seat) => Map<String, dynamic>.from(seat)).toList();
    }

    return reservationDate[newSeatDate]!;
  }

  @override
  void initState() {
    super.initState();
    changeSeats(date);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> nowSeatData = changeSeats(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 현황'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(234, 225, 201, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 5),
                        Text('선택 가능'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red),
                        SizedBox(width: 5),
                        Text('선택 불가능'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final selectedData = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 90),
                          ),
                        );
                        if (selectedData != null) {
                          setState(() {
                            date = selectedData;
                          });
                        }
                      },
                    ),
                    Text('${date.year}-${date.month}-${date.day}'),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 233, 233),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      ...nowSeatData.map((seat) => _seatIconButton(seat)),
                      Positioned(
                        top: 275,
                        left: 300,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: const Icon(
                            Icons.local_cafe,
                            color: Colors.brown,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 340,
                        left: 300,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: const Icon(
                            Icons.wc,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap:
                  nowSeatData.any((seat) => seat['isSelected'] == true)
                      ? () => Get.to(
                        () => ReservationScreen(
                          reservationInfo: ReservationInfo(
                            reservationDate: date,
                            uid: FirebaseAuth.instance.currentUser?.uid,
                            seatInfo:
                                nowSeatData.firstWhere(
                                  (seat) => seat['isSelected'] == true,
                                )['seatNumber'],
                          ),
                        ),
                      )
                      : null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        nowSeatData.any((seat) => seat['isSelected'] == true)
                            ? Colors.red
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '예약하기',
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
      ),
    );
  }

  Widget _seatIconButton(Map<String, dynamic> seat) {
    final double top = (seat['top'] as int).toDouble();
    final double left = (seat['left'] as int).toDouble();
    bool isReserved = seat['isReserved'];
    bool isSelected = seat['isSelected'] ?? false;
    String seatNumber = seat['seatNumber'];

    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.event_seat),
              color:
                  isReserved
                      ? Colors.red
                      : (isSelected ? Colors.amber : Colors.green),
              iconSize: 25,
              onPressed: () {
                setState(() {
                  if (isReserved) {
                    seat['isReserved'] = false;
                  } else {
                    if (isSelected) {
                      seat['isReserved'] = true;
                      seat['isSelected'] = false;
                    } else {
                      seat['isSelected'] = true;
                    }
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                seatNumber,
                style: const TextStyle(fontSize: 10, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
