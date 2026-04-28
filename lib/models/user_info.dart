// 앱 이용 사용자 정보 추상화 목적
class UserInfo {
  String? name;
  String? email;
  String? profileImagePath;

  // 생성자 초기화
  UserInfo({
    this.name,
    this.email,
    this.profileImagePath
  });

  // 객체의 데이터를 DB에 insert sqflite.. Map 으로 만들어서
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImagePath': profileImagePath,
    };
  }

  // db select, map 으로 전달되어서, map 데이터로 객체 생성
  // 개발자가 뭔가 알고리즘 요소를 넣고싶은 생성자
  // factory는 외부적으로는 그냥 클래스이다.
  // 하지만, 직접 개발자가 객체를 만들어서 리턴시켜줘야한다.
  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'],
      email: map['email'],
      profileImagePath: map['profileImagePath'],
    );
  }
}