import 'package:flutter/material.dart';

import 'calendar_models.dart';
import 'calendar_popup_card.dart';

class CalendarPopupSection extends StatelessWidget {
  const CalendarPopupSection({super.key, required this.items});

  final List<CalendarPopupItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '선택한 날짜의 팝업',
          style: TextStyle(
            color: Color(0xFF1C1B1C),
            fontSize: 20,
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CalendarPopupCard(item: item),
          ),
        ),
      ],
    );
  }
}
