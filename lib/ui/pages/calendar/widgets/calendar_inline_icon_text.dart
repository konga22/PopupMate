import 'package:flutter/material.dart';

class CalendarInlineIconText extends StatelessWidget {
  const CalendarInlineIconText({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF45474B), size: 13),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF45474B),
              fontSize: 13,
              height: 1.25,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
