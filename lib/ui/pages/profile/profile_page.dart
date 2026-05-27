import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../services/mock_profile_service.dart';
import '../../common/app_components.dart';
import 'widgets/profile_account_section.dart';
import 'widgets/profile_badge_section.dart';
import 'widgets/profile_stats_row.dart';
import 'widgets/profile_summary_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = MockProfileService.me;

    return MainShellPage(
      activeTab: AppTab.profile,
      title: '마이페이지',
      actions: [
        IconButton(
          onPressed: () => showNotReadySnackBar(context),
          icon: const Icon(LucideIcons.settings),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          ProfileSummaryHeader(profile: profile),
          24.heightBox,
          ProfileStatsRow(profile: profile),
          28.heightBox,
          ProfileBadgeSection(
            badges: profile.badges,
            onManageBadges:
                () => context.pushNamed(
                  AppPage.profileDetail.name,
                  pathParameters: {'id': 'curator-jun'},
                ),
          ),
          28.heightBox,
          ProfileAccountSection(
            onItemTap: (_) => showNotReadySnackBar(context),
          ),
        ],
      ),
    );
  }
}
