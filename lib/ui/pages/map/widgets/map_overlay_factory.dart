import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../models/popup_models.dart';

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

  static List<NAddableOverlay> overlays({
    required NLatLng center,
    required double radius,
    required List<Popup> filteredPopups,
    required ValueChanged<Popup> onPopupSelected,
    required Map<String, NOverlayImage> categoryMarkerIcons,
  }) {
    final list = <NAddableOverlay>[
      searchRadiusCircle(center: center, radius: radius),
    ];

    for (final popup in filteredPopups) {
      if (popup.latitude != null && popup.longitude != null) {
        final icon = categoryMarkerIcons[popup.category];
        final marker = NMarker(
          id: 'pin_marker_${popup.id}',
          position: NLatLng(popup.latitude!, popup.longitude!),
          caption: NOverlayCaption(text: popup.title),
          icon: icon,
          size: icon != null ? const Size(48, 48) : const Size(28, 28),
        );
        marker.setOnTapListener((_) {
          onPopupSelected(popup);
        });
        list.add(marker);
      }
    }

    return list;
  }
}
