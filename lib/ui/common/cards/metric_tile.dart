import 'package:flutter/material.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/theme/app_theme.dart';

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.softBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.ink, size: 20),
            12.heightBox,
            Text(
              value,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            4.heightBox,
            Text(
              label,
              style: const TextStyle(color: AppColors.muted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
