import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
import 'widgets/home_closing_section.dart';
import 'widgets/home_design_tokens.dart';
import 'widgets/home_floating_report_button.dart';
import 'widgets/home_header.dart';
import 'widgets/home_hero_section.dart';
import 'widgets/home_quick_menu.dart';
import 'widgets/home_trending_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final heroHeight = (480 - MediaQuery.viewPaddingOf(context).top).clamp(
      420,
      480,
    );

    return Scaffold(
      backgroundColor: HomeColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                const HomeHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 112),
                    children: [
                      HomeHeroSection(height: heroHeight.toDouble()),
                      const SizedBox(height: 32),
                      const HomeQuickMenu(),
                      const SizedBox(height: 32),
                      const HomeTrendingSection(),
                      const HomeClosingSection(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 16,
              child: HomeFloatingReportButton(
                onTap: () => context.pushNamed(AppPage.communityWrite.name),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.home),
    );
  }
}
