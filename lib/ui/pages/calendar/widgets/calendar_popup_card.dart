import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/router/app_page.dart';
import '../../../../app/theme/app_theme.dart';
import 'calendar_inline_icon_text.dart';
import 'calendar_models.dart';
import 'calendar_popup_status_pill.dart';

class CalendarPopupCard extends StatelessWidget {
  const CalendarPopupCard({super.key, required this.item});

  final CalendarPopupItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap:
          () => context.pushNamed(
            AppPage.popupDetail.name,
            pathParameters: {'id': item.id},
          ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F3F3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                item.image,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 96,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CalendarPopupStatusPill(
                          label: item.status,
                          urgent: item.urgent,
                        ),
                        const Spacer(),
                        const Icon(
                          LucideIcons.heart,
                          color: AppColors.muted,
                          size: 17,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF1C1B1C),
                        fontSize: 16,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    CalendarInlineIconText(
                      icon: LucideIcons.calendarDays,
                      label: item.period,
                    ),
                    const SizedBox(height: 2),
                    CalendarInlineIconText(
                      icon: LucideIcons.mapPin,
                      label: item.area,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
