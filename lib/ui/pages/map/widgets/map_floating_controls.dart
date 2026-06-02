import 'package:flutter/material.dart';

import 'map_current_location_button.dart';
import 'map_radius_dropdown.dart';

class MapFloatingControls extends StatelessWidget {
  final String radiusLabel;
  final List<int> radiusOptions;
  final int selectedRadius;
  final ValueChanged<int> onRadiusSelected;
  final VoidCallback onCurrentLocationTap;

  const MapFloatingControls({
    super.key,
    required this.radiusLabel,
    required this.radiusOptions,
    required this.selectedRadius,
    required this.onRadiusSelected,
    required this.onCurrentLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MapRadiusDropdown(
          label: '$radiusLabel 반경',
          options: radiusOptions,
          selectedRadius: selectedRadius,
          onSelected: onRadiusSelected,
        ),
        MapCurrentLocationButton(onTap: onCurrentLocationTap),
      ],
    );
  }
}
