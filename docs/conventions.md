# Conventions

이 문서는 PopupMate에서 새 코드를 작성하거나 기존 파일을 분리할 때 지키는 기준이다.
자세한 폴더 책임은 `docs/architecture.md`를 먼저 확인한다.

## 기본 작성 원칙

- Flutter/Dart 관례를 따르되, 화면 파일은 읽기 쉬운 조립 코드로 유지한다.
- `main.dart`는 얇게 유지한다.
- route path는 `AppPage`에만 둔다.
- 하단 탭 흐름은 `goNamed`, 상세/작성/대기 같은 임시 flow는 `pushNamed`, 닫기는 `pop`을 사용한다.
- 색상과 공통 스타일은 `AppTheme`, `AppColors`를 우선 사용한다.
- 아이콘은 `lucide_icons_flutter`를 기본으로 사용한다.
- 사용자에게 보이는 안내는 짧은 한국어 snackbar로 보여준다.

## 파일 네이밍

| 대상 | 규칙 | 예시 |
| --- | --- | --- |
| 파일명 | lower_snake_case | `community_post_list.dart` |
| Page class | PascalCase + `Page` | `CommunityPage` |
| Page state | `_PageNameState` | `_CommunityPageState` |
| 화면 전용 위젯 | Feature prefix + 역할 | `CommunityFilterSheet` |
| 공통 위젯 | 역할 중심 이름 | `PrimaryButton`, `SectionHeader` |
| 서비스 | Feature + `Service` | `CommunityService` |
| 모델 | 의미 중심 이름 | `CommunityPost`, `PopupStore` |

## Page 작성 기준

Page 파일은 아래 정도만 소유한다.

- controller 생성/해제
- 현재 화면의 local state
- route 이동
- service 호출의 시작점
- shell/scaffold 조립
- 화면 전용 위젯에 필요한 callback 전달

Page 파일에 아래가 커지면 `widgets/`로 분리한다.

- 카드 UI
- 목록 UI
- 섹션 header + body 묶음
- modal/bottom sheet
- stream/list/fallback 렌더링
- 입력 form

## Widget 분리 기준

- 한 화면에서만 쓰면 `lib/ui/pages/<feature>/widgets/`에 둔다.
- 두 화면 이상에서 쓰면 `lib/ui/common/<role>/`로 올린다.
- 공통 위젯으로 올릴 때는 특정 feature model/service에 의존하지 않게 만든다.
- 위젯 생성자에는 화면이 이해하기 쉬운 값과 callback만 넘긴다.
- 불필요한 boolean prop이 늘어나면 역할이 다른 위젯으로 나누는 것을 검토한다.

## Service 작성 기준

- Firestore, Auth, Location, API, mock data는 `services/`에서 처리한다.
- UI 파일에서 collection path, API URL, query 조건 세부 구현을 반복하지 않는다.
- 기능별 구현은 `services/<feature>/`에 두고, 기존 import 안정성이 필요하면 루트 `*_service.dart`에서 export한다.
- async 이후 UI state를 바꿀 때는 `mounted`를 확인한다.
- 실패 시 화면에서는 짧은 메시지만 보여주고, 복잡한 fallback 기준은 service 또는 전용 위젯에 둔다.

## Form 작성 기준

- `TextEditingController`는 `State`에서 만들고 `dispose`한다.
- 입력값은 service 호출 전에 validate한다.
- submit 중복을 막아야 하면 loading state를 둔다.
- `await` 이후에는 `if (!mounted) return;`을 확인한다.
- snackbar 문구는 짧고 사용자가 다음 행동을 알 수 있게 쓴다.

## Routing 기준

- root tab 전환: `context.goNamed(AppPage.<page>.name)`
- detail/write/waiting flow 진입: `context.pushNamed(AppPage.<page>.name)`
- modal/임시 flow 종료: `context.pop()` 또는 `Navigator.of(context).pop()`
- route path string을 화면 파일에 직접 쓰지 않는다.
- 새 화면을 추가하면 `AppPage`, `appRouter`, 필요 시 `AppTab`을 함께 확인한다.

## Design 기준

- Figma를 우선 기준으로 삼되, 앱 전체 공통성은 `AppTheme`에 모은다.
- Flutter에는 CSS 파일이 없으므로 반복 스타일은 아래 방식으로 분리한다.
  - 앱 전역 색상/테마: `lib/app/theme/app_theme.dart`
  - 화면 전용 값: `<feature>_design_tokens.dart`
  - 재사용 UI: `lib/ui/common/`
- 하단 네비, top bar, 버튼, field, chip처럼 반복되는 UI는 common으로 올린다.
- 화면 전용 hero, card, section은 page의 `widgets/`에 둔다.

## PR 전 확인

```bash
dart format lib test
flutter analyze
flutter test
git diff --check
```

네이버 지도 키가 필요한 실행/빌드는 아래처럼 값을 주입한다.

```bash
flutter run --dart-define=NAVER_MAP_CLIENT_ID=네이버_지도_Client_ID
flutter build apk --debug --dart-define=NAVER_MAP_CLIENT_ID=네이버_지도_Client_ID
```
