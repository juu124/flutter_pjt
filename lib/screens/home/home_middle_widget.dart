import 'package:flutter/material.dart';

class HomeMiddleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // 가로방향으로 정렬. MainAxisAlignment.start가 기본값이다.
      mainAxisAlignment: MainAxisAlignment.spaceBetween,    // 양쪽 벌어짐
      children: [
        Text(
          '인기여행지',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('전체 여행지 보기'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
