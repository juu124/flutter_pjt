import 'package:flutter/material.dart';
import 'package:flutter_pjt/models/trip_destination.dart';
import 'package:flutter_pjt/providers/news_provider.dart';
import 'package:flutter_pjt/providers/trip_provider.dart';
import 'package:flutter_pjt/providers/user_provider.dart';
import 'package:flutter_pjt/screens/about_screen.dart';
import 'package:flutter_pjt/screens/detail_screen.dart';
import 'package:flutter_pjt/screens/myinfo_screen.dart';
import 'package:provider/provider.dart';
import './routes/app_routes.dart';
import './screens/home_screen.dart';

void main() {
  //constant constructor, const 예약어로 생성, 필수는 아니지만 위젯에서 권장사항..
  //동일 매개변수로 객체 재사용.. 위젯은 불변이기 때문에..
  runApp(const TripApp());
}

class TripApp extends StatelessWidget {
  //모든 위젯은 키를 가질 수 있다..
  const TripApp({super.key});

  @override
  Widget build(BuildContext context) {
    //테마설정 + 라이팅 등록 + 앱 전역 상태 등록
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TripProvider()),
        // 초기 데이터 로딩하기 위해서 loadUserData() 함수를 호출해야한다.
        // TripProvider는 내부에 이미 데이터가 있어서 초기 데이터 로딩이 필요없었다.
        // 등록하면서 loadUserData를 그냥 호출하면 안된다. 리턴 타입이 맞지 않는다.
        // 그래서 .. 이라고 적어야한다. ..으로 해서 UserProvider를 한번 생성하면서 loadUserData를 호출한다는 의도이다.
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserData()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => HomeScreen(),
          AppRoutes.about: (context) => AboutScreen(),
          AppRoutes.myInfo: (context) => MyinfoScreen(),
        },
        onGenerateRoute: (settings) {
          // 어디선가 routing 명령 내려졌을때..
          if (settings.name == AppRoutes.detail) {
            // 요청시 추가된 전달 데이터 획득
            final destination = settings.arguments as TripDestination;
            return MaterialPageRoute(
              builder: (context) => DetailScreen(destination),
            );
          }
        },
      ),
    );
  }
}
