import 'package:flutter/material.dart';

class CalendarWeekdayHeader extends StatelessWidget {
  const CalendarWeekdayHeader({super.key});

  static const _weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
