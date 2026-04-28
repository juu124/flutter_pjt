// dbms 처리 코드 추상화
// Widget에 B/L까지 있으면 코드가 길어져서 따로 분리한 것. 원래 한곳에 코딩하면 위젯에 있어야하는 코드
// 항목을 Service로 뺀것이다. (화면 주 목적이 아님)
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_info.dart';

class DatabaseHelper {
  // 생성자...
  // 클래스명.함수 -> 생성자 호출
  // 언더스코어로 호출되니 외부에서 호출 불가능
  // 내부에서만 객체 생성이 가능하다. -> Singleton으로 유지하고 싶어서
  // 객체를 많이 생성하기보다 하나만 생성해서 전역으로 싱글톤 사용하는게 목적
  DatabaseHelper._init();

  static final DatabaseHelper instance =
      DatabaseHelper._init(); // 객체를 하나만 유지하기 위한 코드

  // 데이터 베이스 초기화. 한번만 하면 된다.
  // Database 객체의 함수를 이용해서 insert/update/delete/query를 하는데
  // 외부에서 직접 Database 객체를 사용하는 것이 아니라.. 이 Helper 클래스의 함수를 호출해서
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!; //
    _database = await _initDB('user_info.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // 각 플랫폼에 맞는 db file 저장 디렉토리 경로 획득..
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB); // 버전이 변경되지 않는이상 최초 한번
  }

  Future _createDB(Database db, int version) async {
    // 테이블 생성
    db.execute('''
      CREATE TABLE user_info (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        profileImagePath TEXT
      )
    ''');
  }

  // 위젯에서 DBMS 작업을 위해서 호출할 함수들.. 필요하면 여기에 선언
  Future<void> insertOrUpdateUser(UserInfo userInfo) async {
    final db = await instance.database;
    await db.delete('user_info'); // 테이블 데이터 삭제
    await db.insert('user_info', userInfo.toMap()); // 새로운 데이터 저장
  }

  // DB 저장 데이터 획득을 위해서 호출..
  Future<UserInfo?> getUser() async {
    final db = await instance.database;
    final maps = await db.query('user_info');
    if (maps.isNotEmpty) {
      return UserInfo.fromMap(maps.first);
    }
    return null;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
