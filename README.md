# PopupMate

PopupMate는 한국의 팝업 스토어를 탐색, 저장, 공유하는 모바일 앱입니다. 현재 버전은 Figma 최종본을 Flutter로 옮기는 리빌드 단계이며, Google 소셜 로그인이 연동되어 있습니다.

## Tech Stack

| Area | Stack |
| --- | --- |
| Framework | Flutter |
| Language | Dart |
| Routing | go_router |
| Icons | lucide_icons_flutter |
| Auth | Firebase Auth + Google Sign-In |
| Database | Cloud Firestore (커뮤니티), Mock service (나머지) |
| State | Local widget state |
| Target | iOS / Android |

## Getting Started

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Android Emulator:

```bash
flutter run -d android
```

iOS Simulator:

```bash
flutter run -d ios
```

## Project Structure

```text
lib/
  main.dart
  app/
    router/       # GoRouter + AppPage enum
    theme/        # AppTheme, AppColors
    extensions/   # BuildContext, spacing
    assets/       # AppAssets (에셋 경로 상수)
  models/
  services/
    google_auth_service.dart   # Google Sign-In
    community_service.dart     # Firestore 연동
    mock_*.dart                # 나머지 Mock 데이터
  ui/
    common/       # AppTopBar, AppBottomNavBar, PopupCard 등
    pages/
      auth/       # loading, onboarding, permission, login
      home/
      search/
      map/
      community/
      popup/
      calendar/
      profile/
      waiting/
      review/
      inventory/
assets/
  images/
  fonts/          # SUITE, MoveSans, MoneygraphyRounded
```

## Current Scope

- Figma `409:11104` 최종본 기준 UI 구현
- Google 소셜 로그인 (Firebase Auth)
- 커뮤니티 게시글/댓글/좋아요 (Cloud Firestore 실연동)
- 로딩 → 온보딩 → 권한 → 로그인 → 홈 진입 플로우
- 하단 탭: Search, Map, Home, Community, Profile
- Popup detail, reviews, waiting, inventory, calendar, profile detail (Mock)

## Firebase 설정 (신규 개발자)

1. [Firebase Console](https://console.firebase.google.com) → `popupmate-cff31` 프로젝트 접속
2. Authentication → Sign-in method → **Google 사용 설정**
3. 프로젝트 설정 → SHA 인증서 지문 → 디버그 SHA-1 추가
   ```bash
   cd android && ./gradlew signingReport
   ```
4. 업데이트된 `google-services.json` 다운로드 → `android/app/` 교체

## Team Workflow

- `master`: stable / release
- `dev`: integration branch
- `team/<github-id>`: 개인 작업 브랜치
- PR은 `dev` 대상으로 만들고 PM이 최종 merge합니다.

## Changelog

### [2026-05-27] Google 로그인 구현 (`team/skngyj`)

- `google_sign_in` 패키지 추가
- `GoogleAuthService` 구현 (Firebase Auth 연동)
- 로그인 화면 Apple 버튼 → **Google로 로그인** 버튼 교체
- Google 로고 SVG 에셋 추가 (`assets/images/login_google.svg`)
- `main.dart` Firebase 초기화 예외 처리 (미지원 플랫폼 대응)

## Checks Before PR

```bash
dart format lib test
flutter analyze
flutter test
git diff --check
```
