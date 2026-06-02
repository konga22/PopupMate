import 'package:flutter/material.dart';

import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
import 'widgets/calendar_data.dart';
import 'widgets/calendar_grid.dart';
import 'widgets/calendar_header.dart';
import 'widgets/calendar_month_header.dart';
import 'widgets/calendar_popup_section.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CalendarHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                children: [
                  const CalendarMonthHeader(),
                  const SizedBox(height: 16),
                  const CalendarGrid(),
                  const SizedBox(height: 48),
                  const CalendarPopupSection(items: calendarPopupItems),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.home),
    );
  }
}
