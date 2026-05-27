import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'map_radius_button.dart';
import 'map_radius_option.dart';

class MapRadiusDropdown extends StatelessWidget {
  const MapRadiusDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.selectedRadius,
    required this.onSelected,
  });

  final String label;
  final List<int> options;
  final int selectedRadius;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: selectedRadius,
      onSelected: onSelected,
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      color: Colors.white,
      elevation: 15,
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return options.map((option) {
          final isSelected = option == selectedRadius;
          final optionLabel = option == 1000 ? '1km' : '${option}m';

          return PopupMenuItem<int>(
            value: option,
            height: 36,
            padding: EdgeInsets.zero,
            child: MapRadiusOption(label: optionLabel, selected: isSelected),
          );
        }).toList();
      },
      child: MapRadiusButton(label: label),
    );
  }
}
