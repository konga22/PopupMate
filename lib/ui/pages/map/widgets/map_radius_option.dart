import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class MapRadiusOption extends StatelessWidget {
  const MapRadiusOption({
    super.key,
    required this.label,
    required this.selected,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color:
          selected
              ? AppColors.surfaceAlt.withValues(alpha: 0.5)
              : Colors.transparent,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: selected ? AppColors.ink : const Color(0xFF1C1B1C),
          fontSize: 14,
          height: 1.43,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
