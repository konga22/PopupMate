import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/mock_models.dart';
import '../../../common/app_components.dart';

class ProfileBadgeSection extends StatelessWidget {
  const ProfileBadgeSection({
    super.key,
    required this.badges,
    required this.onManageBadges,
  });

  final List<UserBadge> badges;
  final VoidCallback onManageBadges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: '대표 뱃지',
          trailing: TextButton(
            onPressed: onManageBadges,
            child: const Text('뱃지 관리'),
          ),
        ),
        16.heightBox,
        ...badges.map((badge) => ProfileBadgeTile(badge: badge)),
      ],
    );
  }
}

class ProfileBadgeTile extends StatelessWidget {
  const ProfileBadgeTile({super.key, required this.badge});

  final UserBadge badge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.softBorder),
        ),
        leading: const Icon(LucideIcons.badgeCheck),
        title: Text(badge.title),
        subtitle: Text(badge.caption),
      ),
    );
  }
}
