import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'map_floating_controls.dart';
import 'map_naver_view.dart';
import 'map_quick_preview_card.dart';
import 'map_search_bar.dart';

class MapViewport extends StatelessWidget {
  const MapViewport({
    super.key,
    required this.center,
    required this.radius,
    required this.radiusLabel,
    required this.radiusOptions,
    required this.saved,
    required this.onSearch,
    required this.onRadiusSelected,
    required this.onCurrentLocationTap,
    required this.onWaitingTap,
    required this.onSaveTap,
  });

  final NLatLng center;
  final int radius;
  final String radiusLabel;
  final List<int> radiusOptions;
  final bool saved;
  final ValueChanged<String> onSearch;
  final ValueChanged<int> onRadiusSelected;
  final VoidCallback onCurrentLocationTap;
  final VoidCallback onWaitingTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: MapNaverView(center: center, radius: radius.toDouble()),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 16,
          child: Column(
            children: [
              MapSearchBar(onSearch: onSearch),
              const SizedBox(height: 16),
              MapFloatingControls(
                radiusLabel: radiusLabel,
                radiusOptions: radiusOptions,
                selectedRadius: radius,
                onRadiusSelected: onRadiusSelected,
                onCurrentLocationTap: onCurrentLocationTap,
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 32,
          child: MapQuickPreviewCard(
            saved: saved,
            onWaitingTap: onWaitingTap,
            onSaveTap: onSaveTap,
          ),
        ),
      ],
    );
  }
}
