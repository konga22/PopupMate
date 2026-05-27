import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/router/app_page.dart';
import 'home_quick_action.dart';

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
            HomeQuickAction(
              icon: LucideIcons.calendarDays,
              label: '팝업 캘린더',
              route: AppPage.calendar,
            ),
            HomeQuickAction(
              icon: LucideIcons.navigation,
              label: '내 주변 팝업',
              route: AppPage.map,
            ),
            HomeQuickAction(
              icon: LucideIcons.map,
              label: '지역별 팝업',
              route: AppPage.search,
            ),
            HomeQuickAction(
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
