import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../services/mock_profile_service.dart';
import '../../common/app_components.dart';
import 'widgets/profile_detail_header.dart';
import 'widgets/profile_stats_row.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = MockProfileService.other;

    return Scaffold(
      appBar: const AppTopBar(title: '프로필 상세', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          ProfileDetailHeader(profile: profile),
          24.heightBox,
          ProfileStatsRow(profile: profile, reviewLabel: '후기'),
          26.heightBox,
          const SectionHeader(title: '이번 주 추천 팝업'),
          14.heightBox,
          const EmptyPlaceholder(
            title: '최근 활동 내역',
            message: '성수 레이어 갤러리 팝업 방문함 · 2시간 전',
            icon: LucideIcons.activity,
          ),
        ],
      ),
    );
  }
}
