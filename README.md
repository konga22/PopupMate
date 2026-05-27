# PopupMate

PopupMate는 한국의 팝업 스토어를 탐색, 저장, 공유하는 모바일 앱입니다. 현재 버전은 Figma 최종본을 Flutter로 옮기는 mock UI 리빌드 단계입니다.

## Tech Stack

| Area | Stack |
| --- | --- |
| Framework | Flutter |
| Language | Dart |
| Routing | go_router |
| Icons | lucide_icons_flutter |
| State | Local widget state + mock services |
| Target | iOS / Android |

## Getting Started

```bash
flutter pub get
flutter analyze
flutter test
flutter run --dart-define=NAVER_MAP_CLIENT_ID=네이버_지도_Client_ID
```

iOS Simulator:

```bash
flutter run -d ios
```

Android Emulator:

```bash
flutter run -d android
```

## Project Structure

```text
lib/
  main.dart
  app/
    router/
    theme/
    extensions/
  models/
  services/
  ui/
    common/
    pages/
```

## Current Scope

- Figma `409:11104` final section 기준 mock UI 구현
- Loading, Onboarding, Permission, Login, Home 진입 흐름
- 하단 탭: Search, Map, Home, Community, Profile
- Popup detail, reviews, community, waiting, inventory, calendar, profile detail
- Firebase/Auth/Firestore/Storage는 아직 연결하지 않음

## Team Workflow

- `master`: stable/release
- `dev`: integration branch
- `team/<github-id>`: teammate branches
- PR은 `dev` 대상으로 만들고 PM이 최종 merge합니다.

## Checks Before PR

```bash
dart format lib test
flutter analyze
flutter test
git diff --check
```

## 최근 작업 내역 (Recent Updates)

### 🗺️ 네이버 지도 & 위치 서비스 구현 (Map & Location Service)
- **네이버 지도 SDK (`flutter_naver_map`) 연동**: 지도 뷰 및 성수동 중심의 기본 마커 표시 기능 추가
- **위치 서비스 (`geolocator`) 도입**: 사용자 권한 획득 및 실시간 위치 조회 기능 구현 (`LocationService`)
- **플랫폼별 권한 설정**: Android (`AndroidManifest.xml`) 및 iOS (`Info.plist`) 위치 권한 정보 반영
- **지도 페이지 UI 구성 요소 모듈화**:
  - `MapSearchBar`: 지도 내 상단 검색창
  - `MapFloatingControls`: 반경 선택(100m, 500m, 1km) 및 현재 위치 이동 버튼
  - `MapNaverView`: 네이버 지도 플러그인 래핑
  - `MapQuickPreviewCard`: 선택된 팝업 스토어의 요약 정보 제공 카드

### ❤️ 찜하기(하트) 버튼 UI/UX 개선
- **꽉 찬 하트 아이콘 반영**: 찜하기 활성화(`saved == true`) 시 기존 아웃라인 하트에서 속이 꽉 찬 하트(`Icons.favorite`)로 변경
- **색상 스타일 적용**: 활성화 시 하트 내부가 파스텔 핑크 색상(`#DCC5CF`)으로 꽉 채워지도록 수정
- **테두리 박스 고정**: 네모 박스의 테두리는 상태 변화 없이 기존 테두리 색상(`AppColors.border`)을 유지하도록 고정

### 🔒 보안 및 버전 관리 설정
- **네이버 지도 Client ID 주입 방식**: `.env` 파일 대신 `--dart-define=NAVER_MAP_CLIENT_ID=...`로 실행 시점에 값을 전달
- **GitHub Actions Secret 사용**: CI에서는 `secrets.NAVER_MAP_CLIENT_ID` 값을 `--dart-define`으로 전달
- **브랜치 업로드**: `team/kwanhyeak0304/map-setup` 브랜치를 원격 저장소(`kwanhyeak0304/PopupMate`)에 커밋 및 푸시 완료

#### 로컬 실행

```bash
flutter run --dart-define=NAVER_MAP_CLIENT_ID=네이버_지도_Client_ID
```

#### GitHub Actions 실행 예시

```bash
flutter analyze
flutter test --dart-define=NAVER_MAP_CLIENT_ID=${{ secrets.NAVER_MAP_CLIENT_ID }}
flutter build apk --dart-define=NAVER_MAP_CLIENT_ID=${{ secrets.NAVER_MAP_CLIENT_ID }}
```
