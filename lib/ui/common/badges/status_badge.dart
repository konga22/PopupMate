import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';

enum BadgeTone { neutral, success, warning, danger }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.tone = BadgeTone.neutral,
  });

  final String label;
  final BadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final background = switch (tone) {
      BadgeTone.neutral => AppColors.chip,
      BadgeTone.success => const Color(0xFFE8F2EA),
      BadgeTone.warning => const Color(0xFFFFF3DF),
      BadgeTone.danger => const Color(0xFFFFE7E7),
    };
    final foreground = switch (tone) {
      BadgeTone.neutral => AppColors.body,
      BadgeTone.success => AppColors.success,
      BadgeTone.warning => AppColors.warning,
      BadgeTone.danger => AppColors.danger,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
