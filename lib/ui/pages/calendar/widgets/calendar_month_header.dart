import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class CalendarMonthHeader extends StatelessWidget {
  const CalendarMonthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            '2024년 12월',
            style: TextStyle(
              color: Color(0xFF1C1B1C),
              fontSize: 24,
              height: 1.33,
              letterSpacing: -0.24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(LucideIcons.chevronLeft, color: AppColors.body, size: 20),
        SizedBox(width: 16),
        Icon(LucideIcons.chevronRight, color: AppColors.body, size: 20),
      ],
    );
  }
}
