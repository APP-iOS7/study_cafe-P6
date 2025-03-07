import 'package:flutter/material.dart';

class SeatPageView extends StatefulWidget {
  const SeatPageView({super.key});

  @override
  State<SeatPageView> createState() => _SeatPageViewState();
}

class _SeatPageViewState extends State<SeatPageView> {
  // 좌석 데이터
  final List<Map<String, dynamic>> seats = [
    // 집중존
    {'top': 8, 'left': 8, 'isReserved': false},
    {'top': 8, 'left': 70, 'isReserved': false},
    {'top': 68, 'left': 8, 'isReserved': false},
    {'top': 68, 'left': 70, 'isReserved': false},
    {'top': 8, 'left': 130, 'isReserved': true},
    {'top': 68, 'left': 130, 'isReserved': false},
    {'top': 128, 'left': 8, 'isReserved': true},
    {'top': 128, 'left': 70, 'isReserved': false},
    {'top': 128, 'left': 130, 'isReserved': false},
    {'top': 188, 'left': 8, 'isReserved': false},
    {'top': 188, 'left': 70, 'isReserved': false},
    {'top': 188, 'left': 130, 'isReserved': false},

    // 노트북존
    {'top': 15, 'left': 220, 'isReserved': false},
    {'top': 10, 'left': 280, 'isReserved': false},
    {'top': 10, 'left': 340, 'isReserved': false},
    {'top': 60, 'left': 220, 'isReserved': false},
    {'top': 70, 'left': 280, 'isReserved': true},
    {'top': 70, 'left': 340, 'isReserved': false},
    {'top': 130, 'left': 225, 'isReserved': false},
    {'top': 130, 'left': 270, 'isReserved': false},
    {'top': 135, 'left': 340, 'isReserved': true},
    {'top': 190, 'left': 220, 'isReserved': false},
    {'top': 190, 'left': 280, 'isReserved': false},
    {'top': 180, 'left': 340, 'isReserved': false},

    // 스터디룸 (4인)
    {'top': 300, 'left': 20, 'isReserved': false},
    {'top': 300, 'left': 70, 'isReserved': false},
    {'top': 350, 'left': 20, 'isReserved': false},
    {'top': 350, 'left': 70, 'isReserved': false},

    {'top': 430, 'left': 20, 'isReserved': true},
    {'top': 430, 'left': 70, 'isReserved': true},
    {'top': 480, 'left': 20, 'isReserved': false},
    {'top': 480, 'left': 70, 'isReserved': false},

    // 스터디룸 (6인)
    {'top': 300, 'left': 190, 'isReserved': false},
    {'top': 300, 'left': 240, 'isReserved': false},
    {'top': 300, 'left': 290, 'isReserved': false},
    {'top': 350, 'left': 190, 'isReserved': false},
    {'top': 350, 'left': 240, 'isReserved': true},
    {'top': 350, 'left': 290, 'isReserved': true},

    {'top': 430, 'left': 190, 'isReserved': false},
    {'top': 430, 'left': 240, 'isReserved': true},
    {'top': 430, 'left': 290, 'isReserved': false},
    {'top': 480, 'left': 190, 'isReserved': false},
    {'top': 480, 'left': 240, 'isReserved': true},
    {'top': 480, 'left': 290, 'isReserved': false},
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
                    children:
                        seats.map((seat) => _seatIconButton(seat)).toList(),
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

  Widget _seatIconButton(Map<String, dynamic> seat) {
    final double top = (seat['top'] as int).toDouble();
    final double left = (seat['left'] as int).toDouble();
    bool isReserved = seat['isReserved'];

    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        width: 45,
        height: 45,
        child: IconButton(
          icon: const Icon(Icons.event_seat),
          color: isReserved ? Colors.red : Colors.green,
          iconSize: 35,
          onPressed:
              isReserved
                  ? () {
                    setState(() {
                      seat['isReserved'] = false;
                    });
                  }
                  : () {
                    setState(() {
                      seat['isReserved'] = true;
                    });
                  },
        ),
      ),
    );
  }
}
