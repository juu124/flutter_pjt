import 'package:flutter/material.dart';

import '../../models/trip_destination.dart';

class ProductDialogWidget extends StatelessWidget {
  final TripDestination destination;
  final int index;

  ProductDialogWidget(this.destination, this.index);

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
                    '${destination.name} 여행 상품 ${index + 1}',
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
                      image: AssetImage(destination.imagePath),
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
                          '1월 1일 ~ 1월 15일 (14박 15일)',
                        ),
                        _buildSummaryItem(Icons.attach_money, '가격', '350만원'),
                        _buildSummaryItem(
                          Icons.airplanemode_active,
                          '항공',
                          '대한항공',
                        ),
                        _buildSummaryItem(
                          Icons.hotel,
                          '호텔',
                          '전 일정 4성급 이상 호텔',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

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
                    SizedBox(height: 10),

                    // ── 일차별 상세 일정 ──
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDaySchedule(
                              day: '1일차',
                              items: [
                                '인천공항 출발 (대한항공 KE093, 13:20)',
                                '취리히 공항 도착 후 호텔 체크인',
                                '취리히 구시가지 자유 관광',
                              ],
                            ),
                            _buildDaySchedule(
                              day: '2일차',
                              items: [
                                '루체른 이동 (약 1시간)',
                                '카펠교 및 빈사의 사자상 관람',
                                '리기산 등반 및 파노라마 전망 감상',
                              ],
                            ),
                            _buildDaySchedule(
                              day: '3일차',
                              items: [
                                '인터라켄 이동 (약 2시간)',
                                '융프라우요흐 등반 (유럽의 지붕, 3,454m)',
                                '알프스 설원 자유 시간',
                              ],
                            ),
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
  Widget _buildDaySchedule({required String day, required List<String> items}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDayChip(day),
          SizedBox(height: 6),
          ...items.map((item) => _buildScheduleItem(item)),
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
          SizedBox(width: 12),
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
