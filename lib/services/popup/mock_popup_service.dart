import '../../models/popup_models.dart';
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
}
