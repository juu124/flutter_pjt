import 'package:flutter/material.dart';
import '../models/user_info.dart';
import '../services/database_helper.dart';

// 앱 전역에서 공통의 데이터 유지
// 상태 쪽에서 dbms=====================
class UserProvider with ChangeNotifier{ // ChangeNotifier : 변경 감지가 필요해서 추가
  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;  // 참조만 하게끔. 직접 수정 X. 함수로 제어해라.

  // 저장된 user 정보가 있는지 판단하기 위해서 이용한다.
  bool get hasUserInfo => _userInfo != null &&
      (_userInfo!.name?.isNotEmpty == true || userInfo!.email?.isNotEmpty == true);

  // 초기 유저 정보를 로딩하기 우해서 호출..
  // db 에 저장되어있는 데이터라서 누군가는 호출해줘야한다.
  Future<void> loadUserData() async {
    _userInfo = await DatabaseHelper.instance.getUser();
    notifyListeners();  // 데이터 변경 감지 하위 위젯 리빌드
  }

  // 유저 정보 저장을 위해서 호출
  Future<void> updateUserInfo(UserInfo userInfo) async {
    await DatabaseHelper.instance.insertOrUpdateUser(userInfo);
    _userInfo = userInfo;
    notifyListeners();
  }

  Future<void> clearUserInfo() async {
    _userInfo = null;
    notifyListeners();
  }
}