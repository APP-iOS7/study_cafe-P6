import 'package:flutter/material.dart';

class ReserveScreen extends StatelessWidget {
  const ReserveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('예약하기'), backgroundColor: Color(0xfff8f2de)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text('Username', style: TextStyle(fontSize: 30)),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final itemlist = [
                    '1 시간',
                    '2 시간',
                    '4시간',
                    '6 시간',
                    '일주일',
                    '한 달',
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              '${itemlist[index]} 이용권',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right_rounded, size: 30),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
