import 'package:flutter/material.dart';
import 'package:flutter_pjt/screens/home/home_middle_widget.dart';
import 'package:flutter_pjt/screens/home/home_top_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold로 사용하면 메뉴와 드로어블 위젯도 가능하다. (물론 드로우 위젯은 Scaffold가 없어도 추가할 수는 있다. Scaffold를 사용하는데 더 편하다.)
      appBar: AppBar(
        // 제목, 메뉴가 있음 (action 추가)
        title: Text('Trip App'),
        actions: [
          // 보통 action은 아이콘으로 구성되서 IconButton 사용
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          HomeTopWidget(),
          ExcludeFocus( // 나머지 전체를 차지하게 하기 주욱 늘어남
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(children: [HomeMiddleWidget()]),
            ),
          ),
        ],
      ),
    );
  }
}
