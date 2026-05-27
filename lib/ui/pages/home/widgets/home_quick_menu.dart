import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/router/app_page.dart';
import 'home_design_tokens.dart';

class HomeQuickMenu extends StatelessWidget {
  const HomeQuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 76.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _QuickAction(
              icon: LucideIcons.calendarDays,
              label: '팝업 캘린더',
              route: AppPage.calendar,
            ),
            _QuickAction(
              icon: LucideIcons.navigation,
              label: '내 주변 팝업',
              route: AppPage.map,
            ),
            _QuickAction(
              icon: LucideIcons.map,
              label: '지역별 팝업',
              route: AppPage.search,
            ),
            _QuickAction(
              icon: LucideIcons.shapes,
              label: '장르별 팝업',
              route: AppPage.search,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final AppPage route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(route.name),
      child: SizedBox(
        width: 78.5,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: HomeColors.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HomeColors.border),
              ),
              child: Center(
                child: Icon(icon, color: HomeColors.title, size: 30),
              ),
            ),
            const SizedBox(height: 7.5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: HomeColors.body,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 12.5 / 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
