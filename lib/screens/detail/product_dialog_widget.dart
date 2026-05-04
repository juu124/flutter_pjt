import 'package:flutter/material.dart';

import '../../models/trip_destination.dart';
import '../../models/trip_product.dart';

class ProductDialogWidget extends StatelessWidget {
  final TripDestination destination;
  final TripProduct product;

  ProductDialogWidget(this.destination, this.product);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: Border.all(style: BorderStyle.none),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 다이얼로그 제목 및 닫기 버튼 영억
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${destination.name} 여행 상품 ${product.id}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('닫기', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),

            // 사진 및 여행 info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(destination.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildSummaryItem(
                          Icons.calendar_month,
                          '일정',
                          product.duration,
                        ),
                        _buildSummaryItem(Icons.attach_money, '가격', product.price),
                        _buildSummaryItem(
                          Icons.airplanemode_active,
                          '항공',
                          product.airline,
                        ),
                        _buildSummaryItem(
                          Icons.hotel,
                          '호텔',
                          product.hotelGrade,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16), // SizedBox는 리빌드 될 필요 x

            // 상세 일정
            // ── 일차 탭 버튼 ──
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '상세 일정',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10), // SizedBox는 리빌드 될 필요 x

                    // ── 일차별 상세 일정 ──
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...product.schedule.map((item) => _buildDaySchedule(item: item)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 일차 칩 버튼
  Widget _buildDayChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 일차별 상세 일정 블록
  Widget _buildDaySchedule({required DaySchedule item}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayChip('${item.day}일차'),   // day: 1 → '1일차'
          const SizedBox(height: 6),
          ...item.activities.map((activity) => _buildScheduleItem(activity)), // activities 배열 순회
        ],
      ),
    );
  }

  // 일정 항목 한 줄
  Widget _buildScheduleItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.blue, fontSize: 14)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // 다이얼로그 상단 여행 정보 위젯 ui
  Widget _buildSummaryItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 12), // SizedBox는 리빌드 될 필요 x
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$label : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 다이얼로그 내부 일정 위젯 ui
  RichText _buildRichText(String title, String info) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(
            text: '$title ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ': $info'),
        ],
      ),
    );
  }
}
