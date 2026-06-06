import '../../models/popup_models.dart';
import '../location_service.dart';
import 'mock_popup_data.dart';

class MockPopupService {
  const MockPopupService._();

  static final popups = MockPopupData.popups;
  static final reviews = MockPopupData.reviews;
  static final inventory = MockPopupData.inventory;
  static final calendarEvents = MockPopupData.calendarEvents;

  static Popup popupById(String id) {
    return popups.firstWhere(
      (popup) => popup.id == id,
      orElse: () => popups.first,
    );
  }

  /// 카테고리, 영업 상태, 현재 중심 GPS 좌표 및 검색 반경을 기준으로 팝업 목록을 필터링하여 반환합니다.
  static List<Popup> getFilteredPopups({
    required Set<String> selectedCategories,
    required PopupStatus? isOperatingFilter,
    required double currentLatitude,
    required double currentLongitude,
    required int radius,
  }) {
    return popups.where((popup) {
      // 1. 카테고리 필터링
      if (selectedCategories.isNotEmpty &&
          !selectedCategories.contains(popup.category)) {
        return false;
      }
      // 2. 영업 상태 필터링
      if (isOperatingFilter != null && popup.status != isOperatingFilter) {
        return false;
      }
      // 3. 반경 필터링
      if (popup.latitude != null && popup.longitude != null) {
        final distance = LocationService.calculateDistance(
          currentLatitude,
          currentLongitude,
          popup.latitude!,
          popup.longitude!,
        );
        if (distance > radius) {
          return false;
        }
      }
      return true;
    }).toList();
  }
}
