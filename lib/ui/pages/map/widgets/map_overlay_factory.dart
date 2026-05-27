import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../../app/theme/app_theme.dart';

class MapOverlayFactory {
  const MapOverlayFactory._();

  static NCircleOverlay searchRadiusCircle({
    required NLatLng center,
    required double radius,
  }) {
    return NCircleOverlay(
      id: 'search_radius_circle',
      center: center,
      radius: radius,
      color: AppColors.ink.withValues(alpha: 0.05),
      outlineColor: AppColors.ink.withValues(alpha: 0.2),
      outlineWidth: 2,
    );
  }

  static NMarker aromaticPopupMarker() {
    return NMarker(
      id: 'pin_marker_aromatic',
      position: const NLatLng(37.5460, 127.0535),
      caption: const NOverlayCaption(text: 'Aromatic Cloud Popup'),
    );
  }

  static NMarker seongsuMainCluster() {
    return NMarker(
      id: 'cluster_marker_1',
      position: const NLatLng(37.5445, 127.0560),
      caption: const NOverlayCaption(text: '12개 팝업'),
    );
  }

  static NMarker seongsuOuterCluster() {
    return NMarker(
      id: 'cluster_marker_2',
      position: const NLatLng(37.5420, 127.0600),
      caption: const NOverlayCaption(text: '5개 팝업'),
    );
  }

  static List<NAddableOverlay> overlays({
    required NLatLng center,
    required double radius,
  }) {
    return [
      searchRadiusCircle(center: center, radius: radius),
      aromaticPopupMarker(),
      if (radius >= 500) seongsuMainCluster(),
      if (radius >= 1000) seongsuOuterCluster(),
    ];
  }
}
