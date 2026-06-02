# Architecture

PopupMate는 Flutter 기반 모바일 앱이며, 화면 UI와 데이터/외부 연동 책임을 분리하는 방식으로 정리한다.
새 사람이든 AI든 이 문서를 보면 "새 파일을 어디에 둘지"와 "기존 파일을 어떻게 읽을지"를 예측할 수 있어야 한다.

## 문서 읽는 순서

1. `README.md`: 프로젝트 실행 방법과 주요 문서 입구
2. `AGENTS.md`: AI/coding agent가 반드시 지켜야 하는 작업 규칙
3. `docs/architecture.md`: 폴더 책임과 파일 배치 기준
4. `docs/conventions.md`: 코드 작성, 네이밍, 검증 규칙
5. `docs/design-system.md`: 색상, 아이콘, UI 톤 기준
6. `docs/screens.md`: 구현된 화면 목록

## 핵심 원칙

- `main.dart`는 앱 진입점만 담당한다.
- 라우팅, 탭, 테마, 확장 함수처럼 앱 전체에 영향을 주는 코드는 `lib/app/`에 둔다.
- 화면은 `lib/ui/pages/<feature>/` 아래에 둔다.
- 한 화면에서만 쓰는 UI 조각은 해당 화면의 `widgets/` 아래에 둔다.
- 두 화면 이상에서 반복되는 UI는 `lib/ui/common/` 아래 역할별 폴더로 올린다.
- 모델은 `lib/models/`, 데이터 조회와 외부 연동은 `lib/services/`에 둔다.
- UI 파일이 Firebase, API, 위치 권한 같은 외부 I/O 세부 구현을 직접 소유하지 않는다.

## 현재 구조

```text
lib/
  main.dart
  app/
    assets/
      app_assets.dart
    extensions/
      context_extension.dart
      spacing_extension.dart
    router/
      app_page.dart
      app_router.dart
      app_tab.dart
    theme/
      app_theme.dart
  models/
    *_models.dart
  services/
    auth/
    community/
    popup/
    profile/
    waiting/
    *_service.dart
  ui/
    common/
      app_components.dart
      badges/
      buttons/
      cards/
      chips/
      feedback/
      fields/
      layout/
      navigation/
    pages/
      auth/
      calendar/
      community/
      home/
      inventory/
      map/
      popup/
      profile/
      review/
      search/
      waiting/
```

## 폴더별 책임

| 위치 | 책임 | 작성 기준 |
| --- | --- | --- |
| `lib/main.dart` | 앱 시작, Firebase 초기화, `AppRoot` 실행 | 진입 코드만 유지하고 화면/서비스 로직을 넣지 않는다 |
| `lib/app/router/` | `AppPage`, `AppTab`, `GoRouter` 관리 | route path를 화면 파일에 하드코딩하지 않는다 |
| `lib/app/theme/` | `AppColors`, `AppTheme` 등 전역 디자인 토큰 | 반복 색상/타이포는 여기로 모은다 |
| `lib/app/extensions/` | `BuildContext`, spacing, safe area helper | 프레임워크 확장성 헬퍼만 둔다 |
| `lib/app/assets/` | 앱에서 참조하는 asset 경로 상수 | 문자열 asset path 중복을 줄인다 |
| `lib/models/` | 화면과 서비스가 공유하는 데이터 타입 | UI import 없이 순수 모델로 유지한다 |
| `lib/services/` | mock 데이터, Firebase, 위치, 인증 같은 데이터/외부 연동 | UI 위젯을 import하지 않는다 |
| `lib/ui/common/` | 여러 화면에서 재사용하는 UI 컴포넌트 | 역할별 폴더에 두고 `app_components.dart`에서 export한다 |
| `lib/ui/pages/<feature>/` | 화면 단위 진입점과 해당 화면 전용 위젯 | page 파일은 조립과 상태 흐름 중심으로 유지한다 |
| `lib/ui/pages/<feature>/widgets/` | 특정 feature에서만 쓰는 작은 UI 단위 | 다른 feature가 쓰기 시작하면 `ui/common/` 승격을 검토한다 |

## Page 구조 기준

각 feature 폴더는 아래 패턴을 따른다.

```text
lib/ui/pages/community/
  community_page.dart
  community_detail_page.dart
  community_write_page.dart
  widgets/
    community_post_list.dart
    community_post_card.dart
    community_filter_sheet.dart
    community_comments_section.dart
```

- `*_page.dart`: route에 직접 연결되는 화면이다. `Scaffold`, 상단/하단 shell, controller, local state, navigation 정도만 소유한다.
- `widgets/`: 한 화면을 구성하는 섹션, 카드, 입력 영역, 액션 행을 둔다.
- 화면이 120~160줄을 넘거나 `build` 안에 큰 UI 블록이 2개 이상 생기면 위젯 분리를 검토한다.
- stream/list/fallback처럼 읽는 사람이 한 덩어리로 이해해야 하는 UI 흐름은 전용 위젯으로 분리한다.

## Common UI 기준

`lib/ui/common/`은 "앱 전체에서 공유되는 UI 도구상자"다.

```text
lib/ui/common/
  app_components.dart
  buttons/
  cards/
  chips/
  feedback/
  fields/
  layout/
  navigation/
```

- 새 공통 컴포넌트를 만들면 역할별 폴더에 파일을 추가한다.
- 외부에서 import하기 쉽도록 `app_components.dart`에 export를 추가한다.
- 공통 컴포넌트는 특정 화면의 모델이나 서비스에 의존하지 않는다.
- 예외적으로 `navigation/app_bottom_nav_bar.dart`처럼 앱 전역 라우팅과 연결되는 컴포넌트는 `AppTab` 정도만 참조한다.

## Services 구조 기준

`lib/services/`는 화면이 직접 처리하면 복잡해지는 데이터 흐름을 맡는다.

```text
lib/services/
  auth/
  community/
  popup/
  profile/
  waiting/
  community_service.dart
  google_auth_service.dart
  mock_popup_service.dart
```

- 기능별 실제 구현은 `services/<feature>/` 아래에 둔다.
- 루트의 `*_service.dart` 파일은 기존 import를 덜 깨기 위한 export 파일로 둘 수 있다.
- Firebase/Firestore/Auth/Location 같은 외부 세부 구현은 서비스 내부에 숨긴다.
- mock fallback이 필요한 경우에도 화면 파일이 mock 리스트를 직접 만들지 않고 service를 통한다.

## 새 코드를 어디에 둘지

| 만들 코드 | 위치 |
| --- | --- |
| 새 route path/name | `lib/app/router/app_page.dart` |
| route 연결 | `lib/app/router/app_router.dart` |
| 새 하단 탭 | `lib/app/router/app_tab.dart`, `lib/ui/common/navigation/app_bottom_nav_bar.dart` |
| 전역 색상/텍스트 스타일 | `lib/app/theme/app_theme.dart` |
| 화면 전용 디자인 토큰 | `lib/ui/pages/<feature>/widgets/<feature>_design_tokens.dart` |
| 화면 진입점 | `lib/ui/pages/<feature>/<feature>_page.dart` |
| 화면 전용 카드/섹션 | `lib/ui/pages/<feature>/widgets/` |
| 2개 이상 화면에서 재사용하는 버튼/카드/레이아웃 | `lib/ui/common/<role>/` |
| 데이터 모델 | `lib/models/` |
| Firebase/API/mock/location/auth 로직 | `lib/services/<feature>/` |
| 사용자 안내 snackbar helper | `lib/app/extensions/` 또는 `lib/ui/common/feedback/` |

## Import 방향

허용되는 방향은 대략 아래와 같다.

```text
ui/pages -> ui/common -> app/theme
ui/pages -> services -> models
ui/pages -> app/router
services -> models
app/router -> ui/pages
```

피해야 할 방향:

- `services`가 `ui`를 import하는 것
- `models`가 `ui`, `services`, `router`를 import하는 것
- `ui/common`이 특정 page 전용 위젯이나 특정 service를 import하는 것
- page에서 Firebase collection path, API URL, asset string을 직접 반복하는 것

## README보다 나은 문서 배치

README는 프로젝트의 첫 화면이라 짧고 안정적이어야 한다. 구조 설명이 길어지면 아래처럼 나누는 편이 좋다.

- `README.md`: 실행 방법, 문서 링크, 현재 범위
- `AGENTS.md`: AI/coding agent가 작업 전에 읽는 규칙
- `docs/architecture.md`: 파일 구조와 책임
- `docs/conventions.md`: 작성 스타일과 PR 전 검증
- `docs/design-system.md`: UI 톤, 색상, 아이콘

즉, README 하나에 모든 규칙을 넣기보다 README에서 각 문서로 안내하는 구조가 유지보수에 더 좋다.
