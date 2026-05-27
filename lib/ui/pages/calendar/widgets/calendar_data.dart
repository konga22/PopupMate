import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import 'calendar_models.dart';

const calendarPopupItems = [
  CalendarPopupItem(
    id: 'maison-kitsune',
    title: '성수 XYZ 팝업',
    period: '2024.12.01 - 2024.12.15',
    area: '성수동',
    status: '운영 중',
    image: AppAssets.calendarXyz,
    urgent: false,
  ),
  CalendarPopupItem(
    id: 'object-house',
    title: '한남 모던 갤러리 팝업',
    period: '2024.11.25 - 2024.12.13',
    area: '한남동',
    status: 'D-2 종료 임박',
    image: AppAssets.calendarGallery,
    urgent: true,
  ),
  CalendarPopupItem(
    id: 'aromatic-cloud',
    title: '청담 시그니처 뷰티',
    period: '2024.12.05 - 2024.12.25',
    area: '청담동',
    status: '운영 중',
    image: AppAssets.calendarBeauty,
    urgent: false,
  ),
];

const calendarDayCells = [
  DayCell(label: '24', muted: true),
  DayCell(label: '25', muted: true),
  DayCell(label: '26', muted: true),
  DayCell(label: '27', muted: true),
  DayCell(label: '28', muted: true),
  DayCell(label: '29', muted: true),
  DayCell(label: '30', muted: true),
  DayCell(label: '1', sunday: true),
  DayCell(label: '2', hasEvent: true),
  DayCell(label: '3'),
  DayCell(label: '4'),
  DayCell(label: '5', hasEvent: true),
  DayCell(label: '6'),
  DayCell(label: '7'),
  DayCell(label: '8', sunday: true),
  DayCell(label: '9'),
  DayCell(label: '', icon: LucideIcons.ticket),
  DayCell(label: '11', selected: true),
  DayCell(label: '12'),
  DayCell(label: '13', hasEvent: true),
  DayCell(label: '14'),
  DayCell(label: '...'),
  DayCell(label: '...'),
  DayCell(label: '...'),
  DayCell(label: '...'),
  DayCell(label: '...'),
  DayCell(label: '...'),
  DayCell(label: '...'),
];
