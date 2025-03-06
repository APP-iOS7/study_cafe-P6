import 'package:flutter/material.dart';

class SeatPageView extends StatefulWidget {
  const SeatPageView({super.key});

  @override
  State<SeatPageView> createState() => _SeatPageViewState();
}

class _SeatPageViewState extends State<SeatPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석현황'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(234, 225, 201, 1),
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
                  children: [
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
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {},
                    ),
                    Text('날짜와 시간 선택하기'),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: 400,
                height: 600,
                child: Container(
                  color: Colors.grey,
                  child: Stack(
                    children: [
                      //집중존
                      Positioned(top: 8, left: 10, child: _seatWidget(true)),
                      Positioned(top: 8, left: 70, child: _seatWidget(true)),
                      Positioned(top: 68, left: 10, child: _seatWidget(false)),
                      Positioned(top: 68, left: 70, child: _seatWidget(false)),
                      Positioned(top: 8, left: 130, child: _seatWidget(true)),
                      Positioned(top: 68, left: 130, child: _seatWidget(false)),
                      Positioned(top: 128, left: 10, child: _seatWidget(true)),
                      Positioned(top: 128, left: 70, child: _seatWidget(false)),
                      Positioned(
                        top: 128,
                        left: 130,
                        child: _seatWidget(false),
                      ),
                      Positioned(top: 188, left: 10, child: _seatWidget(false)),
                      Positioned(top: 188, left: 70, child: _seatWidget(false)),
                      Positioned(
                        top: 188,
                        left: 130,
                        child: _seatWidget(false),
                      ),

                      //노트북존
                      Positioned(top: 15, left: 220, child: _seatWidget(false)),
                      Positioned(top: 10, left: 280, child: _seatWidget(true)),
                      Positioned(top: 10, left: 340, child: _seatWidget(false)),
                      Positioned(top: 60, left: 220, child: _seatWidget(false)),
                      Positioned(top: 70, left: 280, child: _seatWidget(true)),
                      Positioned(top: 70, left: 340, child: _seatWidget(false)),
                      Positioned(top: 130, left: 225, child: _seatWidget(true)),
                      Positioned(top: 130, left: 270, child: _seatWidget(true)),
                      Positioned(top: 135, left: 340, child: _seatWidget(true)),
                      Positioned(
                        top: 190,
                        left: 220,
                        child: _seatWidget(false),
                      ),
                      Positioned(
                        top: 190,
                        left: 280,
                        child: _seatWidget(false),
                      ),
                      Positioned(
                        top: 180,
                        left: 340,
                        child: _seatWidget(false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: Text('예약하기')),
          ],
        ),
      ),
    );
  }

  Widget _seatWidget(bool isReserved) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(color: isReserved ? Colors.red : Colors.green),
      child: Center(child: Text(isReserved ? "X" : "O")),
    );
  }
}
