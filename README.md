# Trip App

- 세계 여행지를 탐색하고 여행 상품을 확인할 수 있는 Flutter 기반 여행 앱입니다.
- flutter 연습을 위해서 만든 미니 앱 입니다.
---

## 주요 기능

- 홈 화면 자동 순환 배너 (loop_page_view)
- 여행지 목록 및 상세 화면
- 여행 상품 상세 정보 Dialog
- 여행지 관련 뉴스 및 웹사이트 연결
- 검색 기능 및 검색 기록 저장
- 다크모드 설정
- 알림 설정

---

## 기술 스택

| 분류 | 사용 기술 |
|---|---|
| Framework | Flutter |
| 상태관리 | Provider |
| 네트워킹 | Dio |
| 로컬 저장소 | SharedPreferences |
| 백엔드 | Node.js + Express |
| 기타 | loop_page_view, url_launcher, json_annotation |

---

## 실행 방법

### 백엔드 서버 실행

```bash
cd server
npm install
node server.js
```

서버 실행 후 아래 URL로 접근 가능합니다.
- 안드로이드 에뮬레이터: `http://10.0.2.2:3000`
- iOS 시뮬레이터: `http://localhost:3000`
- 실제 기기: `http://PC의 실제 IP:3000`

> AndroidManifest.xml의 application 태그에 `android:usesCleartextTraffic="true"` 설정 필요

### Flutter 앱 실행

```bash
flutter pub get
flutter run
```

---

## 화면 구성

| 화면 | 설명 |
|---|---|
| Home | 배너, 인기 여행지 목록, 검색 |
| Detail | 여행 상품 목록, 관련 뉴스 |
| My Info | 사용자 정보 입력 및 저장 |
| About | 앱 소개 |
| Settings | 알림 설정, 다크모드 설정 |