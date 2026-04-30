import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

class HomeTopWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeTopWidgetState();
  }
}

// 베너 vo 클래스
class BannerItem {
  final String image;
  final String title;
  final String subtitle;
  const BannerItem({required this.image, required this.title, required this.subtitle});
}

class HomeTopWidgetState extends State<HomeTopWidget> {
  final LoopPageController _controller = LoopPageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  int _currentPage = 0;
  Timer? _timer;

  // pageView를 위한 더미 데이터
  final List<BannerItem> _banners = [
    BannerItem(
        image: 'assets/images/main_bg_1.jpg',
        title: '연말연시 특별 할인 이벤트',
        subtitle: '최대 20% 할인'),
    BannerItem(
        image: 'assets/images/main_australia.jpg',
        title: '뮤지컬 명성황후 \n오페하우스에 등장 기념 이벤트',
        subtitle: '항공권 선착순 마감'),
    BannerItem(
        image: 'assets/images/main_hawaii.jpg',
        title: '지중해 크루즈 여행',
        subtitle: '지금 예약하면 혜택 가득'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) { // 리빌드 필요 X
      if (!_controller.hasClients) return;

      // 0 -> 1 -> 2-> 0 순으로 페이지 전환되게 끔 하기
      _controller.animateToPage(
        _controller.page.toInt() + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // 배너 높이 조절
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          LoopPageView.builder(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return _buildBannerItem(_banners[index]);
            },
          ),
          // 페이지 인디케이터 (하단 점 표시)
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _banners.length,
                    (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // top banner에 맞는 키, 값 map으로 획득 후 위젯 생성 (LoopPageView의 아이템)
  Widget _buildBannerItem(BannerItem banner) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(banner.image),
          fit: BoxFit.cover,
          // 배경 살짝 어둡게 해서 베너 멘트 보이게 하기
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.3),  // withOpacity는 deprecateded 되어서 withValues 사용
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            banner.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8), // SizedBox는 리빌드 될 필요 x
          Text(
            banner.subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // PageView가 실행될때 자동으로 다음 페이지 넘기기 인디케이터 (하단 점 표시)
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),  // 리빌드 필요 X
      margin: const EdgeInsets.only(right: 5),      // 리빌드 필요 X
      height: 8,
      width: _currentPage == index ? 20 : 8,  // 포커스 되고 있는 페이지에 따른 점 크기 변환
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // dispose 될때 타이머, 컨트롤러 해제
  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
