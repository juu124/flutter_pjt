import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  // 싱글톤 인스턴스 저장용
  // SharedPreferences를 사용할 때마다 객체를 생성하는게 좋지 않다고 판단. (어처피 같은 로직에 한번만 만들면 되니까..)
  static SharedPreferences? _prefs;

  // get을 이용해서 수정은 불가능하게
  static Future<SharedPreferences> get _instance async {
    // ??= null일때 객체 생성
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /*
  * 검색어 저장, 기록 등
  * 비동기를 통해서 ui작업이 중단되지 않게 처리
  * SharedPreferences 인스턴스가 있는지 판단 후에 작업 실행
  */

  // 검색어 저장
  static Future<void> setSearchHistory(List<String> history) async {
    final instance = await _instance;
    await instance.setStringList('search_history', history);
  }

  // 검색어 기록 불러오기
  static Future<List<String>> getSearchHistory() async {
    final instance = await _instance;
    return instance.getStringList('search_history') ?? [];
  }
}