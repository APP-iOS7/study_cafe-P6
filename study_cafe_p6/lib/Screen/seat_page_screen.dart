import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_cafe_p6/Screen/Reservation/reservation_screen.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeatPageView extends StatefulWidget {
  final bool isFromHome; // 홈에서 접근했는지 여부
  const SeatPageView({super.key, this.isFromHome = false});

  @override
  State<SeatPageView> createState() => _SeatPageViewState();
}

class _SeatPageViewState extends State<SeatPageView> {
  DateTime date = DateTime.now();
  String? selectedSeat;

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

  void updateSeatReservation(String seatNumber, DateTime reservationDate) {
    final seatsForDate = changeSeats(reservationDate);
    final seat = seatsForDate.firstWhere((s) => s['seatNumber'] == seatNumber);
    seat['isReserved'] = true; // 빨간색으로 변경
    setState(() {
      selectedSeat = null; // 노란색 선택 해제
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> nowSeatData = changeSeats(date);

    return PopScope(
      canPop: widget.isFromHome, // 홈에서 왔을 때만 뒤로가기 가능
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: widget.isFromHome,
          foregroundColor: Colors.white, // 홈에서 왔을 때만 뒤로가기 버튼 표시
          backgroundColor: const Color(0xffd84040),
          title: const Text(
            '좌석 현황',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'EBS Hunminjeongeum',
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.circle, color: Color(0xffd84040)),
                              SizedBox(width: 5),
                              Text('선택 가능'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.circle, color: Color(0xffafafaf)),
                              SizedBox(width: 5),
                              Text('선택 불가능'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              CupertinoIcons.calendar,
                              size: 30,
                              color: Color(0xffd84040),
                            ),
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
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('예약 가능한 좌석', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 235, 235),
                      borderRadius: BorderRadius.circular(10),
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
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: InkWell(
                      onTap:
                          selectedSeat != null
                              ? () => Get.to(
                                () => ReservationScreen(
                                  reservationInfo: ReservationInfo(
                                    reservationDate: date,
                                    uid: FirebaseAuth.instance.currentUser?.uid,
                                    seatInfo: selectedSeat!,
                                  ),
                                ),
                              )
                              : null,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              selectedSeat != null
                                  ? Color(0xffd84040)
                                  : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '예약하기',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'EBS Hunminjeongeum',
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
      ),
    );
  }

  Widget _seatIconButton(Map<String, dynamic> seat) {
    final double top = (seat['top'] as int).toDouble();
    final double left = (seat['left'] as int).toDouble();
    bool isReserved = seat['isReserved'];
    String seatNumber = seat['seatNumber'];
    bool isSelected = selectedSeat == seat['seatNumber'];

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
                      ? Color(0xffafafaf)
                      : (isSelected
                          ? const Color.fromARGB(255, 119, 11, 177)
                          : Color(0xffd84040)),
              iconSize: 25,
              onPressed: () {
                setState(() {
                  if (isReserved) {
                    seat['isReserved'] = false;
                  } else {
                    if (isSelected) {
                      seat['isReserved'] = true;
                      selectedSeat = null;
                    } else {
                      selectedSeat = seatNumber;
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
