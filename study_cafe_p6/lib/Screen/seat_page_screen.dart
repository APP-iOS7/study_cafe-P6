import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_screen.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class SeatPageView extends StatefulWidget {
  const SeatPageView({super.key});

  @override
  State<SeatPageView> createState() => _SeatPageViewState();
}

class _SeatPageViewState extends State<SeatPageView> {
  DateTime date = DateTime.now();

  // 좌석 데이터
  final List<Map<String, dynamic>> seats = [
    // 집중존
    {'top': 8, 'left': 8, 'isReserved': false, 'seatNumber': 'A1'},
    {'top': 8, 'left': 70, 'isReserved': false, 'seatNumber': 'A2'},
    {'top': 68, 'left': 8, 'isReserved': false, 'seatNumber': 'A3'},
    {'top': 68, 'left': 70, 'isReserved': false, 'seatNumber': 'A4'},
    {'top': 8, 'left': 130, 'isReserved': true, 'seatNumber': 'A5'},
    {'top': 68, 'left': 130, 'isReserved': false, 'seatNumber': 'A6'},
    {'top': 128, 'left': 8, 'isReserved': true, 'seatNumber': 'A7'},
    {'top': 128, 'left': 70, 'isReserved': false, 'seatNumber': 'A8'},
    {'top': 128, 'left': 130, 'isReserved': false, 'seatNumber': 'A9'},
    {'top': 188, 'left': 8, 'isReserved': false, 'seatNumber': 'A10'},
    {'top': 188, 'left': 70, 'isReserved': false, 'seatNumber': 'A11'},
    {'top': 188, 'left': 130, 'isReserved': false, 'seatNumber': 'A12'},

    // 노트북존
    {'top': 10, 'left': 220, 'isReserved': false, 'seatNumber': 'B1'},
    {'top': 10, 'left': 280, 'isReserved': false, 'seatNumber': 'B2'},
    {'top': 10, 'left': 340, 'isReserved': false, 'seatNumber': 'B3'},
    {'top': 70, 'left': 220, 'isReserved': false, 'seatNumber': 'B4'},
    {'top': 70, 'left': 280, 'isReserved': true, 'seatNumber': 'B5'},
    {'top': 70, 'left': 340, 'isReserved': false, 'seatNumber': 'B6'},
    {'top': 130, 'left': 220, 'isReserved': false, 'seatNumber': 'B7'},
    {'top': 130, 'left': 280, 'isReserved': false, 'seatNumber': 'B8'},
    {'top': 130, 'left': 340, 'isReserved': true, 'seatNumber': 'B9'},
    {'top': 190, 'left': 220, 'isReserved': false, 'seatNumber': 'B10'},
    {'top': 190, 'left': 280, 'isReserved': false, 'seatNumber': 'B11'},
    {'top': 190, 'left': 340, 'isReserved': false, 'seatNumber': 'B12'},

    // 스터디룸 (4인)
    {'top': 300, 'left': 20, 'isReserved': false, 'seatNumber': 'C1'},
    {'top': 300, 'left': 70, 'isReserved': false, 'seatNumber': 'C2'},
    {'top': 350, 'left': 20, 'isReserved': false, 'seatNumber': 'C3'},
    {'top': 350, 'left': 70, 'isReserved': false, 'seatNumber': 'C4'},

    // 스터디룸 (2인)
    {'top': 430, 'left': 20, 'isReserved': true, 'seatNumber': 'D1'},
    {'top': 430, 'left': 70, 'isReserved': true, 'seatNumber': 'D2'},

    // 스터디룸 (6인)
    {'top': 300, 'left': 150, 'isReserved': false, 'seatNumber': 'E1'},
    {'top': 300, 'left': 200, 'isReserved': false, 'seatNumber': 'E2'},
    {'top': 300, 'left': 250, 'isReserved': false, 'seatNumber': 'E3'},
    {'top': 350, 'left': 150, 'isReserved': false, 'seatNumber': 'E4'},
    {'top': 350, 'left': 200, 'isReserved': true, 'seatNumber': 'E5'},
    {'top': 350, 'left': 250, 'isReserved': true, 'seatNumber': 'E6'},

    // 스터디룸 (3인)
    {'top': 430, 'left': 150, 'isReserved': false, 'seatNumber': 'F1'},
    {'top': 430, 'left': 200, 'isReserved': true, 'seatNumber': 'F2'},
    {'top': 430, 'left': 250, 'isReserved': false, 'seatNumber': 'F3'},
  ];

  @override
  Widget build(BuildContext context) {
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
                          lastDate: DateTime.now().add(Duration(days: 90)),
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
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.53,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 233, 233),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      ...seats.map((seat) => _seatIconButton(seat)),
                      Positioned(
                        top: 320,
                        left: 330,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Icon(
                            Icons.local_cafe,
                            color: Colors.brown,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 400,
                        left: 330,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Icon(Icons.wc, color: Colors.blue, size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap:
                  seats.any((seat) => seat['isSelected'] == true)
                      ? () => Get.to(
                        () => ReservationScreen(
                          reservationInfo: ReservationInfo(
                            reservationDate: date,
                            seatInfo:
                                seats.firstWhere(
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
                        seats.any((seat) => seat['isSelected'] == true)
                            ? Colors.red
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
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
    String seatNumber = seat['seatNumber']; // 좌석 번호 가져오기

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
            Text(
              seatNumber,
              style: TextStyle(fontSize: 10, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
