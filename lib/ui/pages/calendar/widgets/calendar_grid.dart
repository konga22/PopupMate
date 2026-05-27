import 'package:flutter/material.dart';

import 'calendar_data.dart';
import 'calendar_day_cell.dart';
import 'calendar_weekday_header.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

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
          const CalendarWeekdayHeader(),
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
                (context, index) =>
                    CalendarDayCell(cell: calendarDayCells[index]),
          ),
        ],
      ),
    );
  }
}
