import 'package:flutter/material.dart';

//함수의 매개변수를 이용해 카드 모양의 정보 위젯을 리턴하는 함수..
Widget buildFeatureCard({
  required IconData icon,
  required String title,
  required String description,
}){
  return Card(
    elevation: 2,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.blue,),
          const SizedBox(width: 16,), // SizedBox는 리빌드 될 필요 x
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 4,), // SizedBox는 리빌드 될 필요 x
                Text(description, style: TextStyle(fontSize: 14, color: Colors.grey),)
              ],
            ),
          )
        ],
      ),
    ),
  );
}