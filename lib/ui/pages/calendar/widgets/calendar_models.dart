import 'package:flutter/widgets.dart';

class CalendarPopupItem {
  const CalendarPopupItem({
    required this.id,
    required this.title,
    required this.period,
    required this.area,
    required this.status,
    required this.image,
    required this.urgent,
  });

  final String id;
  final String title;
  final String period;
  final String area;
  final String status;
  final String image;
  final bool urgent;
}

class DayCell {
  const DayCell({
    required this.label,
    this.selected = false,
    this.muted = false,
    this.sunday = false,
    this.hasEvent = false,
    this.icon,
  });

  final String label;
  final bool selected;
  final bool muted;
  final bool sunday;
  final bool hasEvent;
  final IconData? icon;
}
