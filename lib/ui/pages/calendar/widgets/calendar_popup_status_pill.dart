import 'package:flutter/material.dart';

class CalendarPopupStatusPill extends StatelessWidget {
  const CalendarPopupStatusPill({
    super.key,
    required this.label,
    required this.urgent,
  });

  final String label;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: urgent ? const Color(0xFFFFDAD6) : const Color(0xFFDFE0E2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: urgent ? const Color(0xFF93000A) : const Color(0xFF616365),
          fontSize: 10,
          height: 1.2,
          fontWeight: urgent ? FontWeight.w400 : FontWeight.w500,
        ),
      ),
    );
  }
}
