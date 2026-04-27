import 'package:flutter/material.dart';
import 'build_feature_card.dart';

// 세로 방향 출력 위젯
class AboutPortraitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: double.infinity, // match_parents
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
