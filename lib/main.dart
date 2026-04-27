import 'package:flutter/material.dart';

import './routes/app_routes.dart';
import './screens/home_screen.dart';

void main() {
  // constant constructor, const 예약어로 생성, 필수는 아니지만 위젯에서 권장 사항이다.
  // const를 붙였다. const를 붙이면 추가로 오는 문법이 있다
  // const 예약어로 TripApp 클래스에 생성자가 선언되어있어야한다.
  // 이렇게 하면 동일 매개변수로 객체 재사용한다. 위젯은 불변이기 때문에..
  // const로 만든 객체는 멤버변수가 final 이기 때문이다.
  runApp(const TripApp());
}

class TripApp extends StatelessWidget {
  // 모든 위젯은 키를 가질 수 있다.
  const TripApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 테마설정 + 라우팅 등록 + 앱 전역 상태 등록을 여기에서 작업한다.
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {AppRoutes.home: (context) => HomeScreen()},
    );
  }
}
