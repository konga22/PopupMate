import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'calendar_data.dart';
import 'calendar_models.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  static const _weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children:
                _weekdays.map((weekday) {
                  return Expanded(
                    child: Text(
                      weekday,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF45474B),
                        fontSize: 12,
                        height: 1.33,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: calendarDayCells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 40,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder:
                (context, index) => _CalendarDay(cell: calendarDayCells[index]),
          ),
        ],
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({required this.cell});

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
