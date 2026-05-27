import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class MapPreviewBadge extends StatelessWidget {
  const MapPreviewBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.ink.withValues(alpha: 0.2)),
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          color: AppColors.ink,
          fontSize: 12,
          height: 1.33,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
