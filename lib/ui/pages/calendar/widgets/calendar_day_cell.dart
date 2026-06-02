import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'calendar_models.dart';

class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({super.key, required this.cell});

  final DayCell cell;

  @override
  Widget build(BuildContext context) {
    final textColor =
        cell.selected
            ? Colors.white
            : cell.sunday
            ? const Color(0xFFBA1A1A)
            : const Color(0xFF1C1B1C);

    return Opacity(
      opacity: cell.muted ? 0.3 : 1,
      child: Container(
        alignment: Alignment.center,
        decoration:
            cell.selected
                ? BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(12),
                )
                : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (cell.icon != null)
              Icon(cell.icon, color: AppColors.ink, size: 15)
            else
              Text(
                cell.label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  height: 1.43,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (cell.hasEvent)
              const Positioned(
                bottom: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(dimension: 4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
