import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../models/mock_models.dart';
import '../../../common/app_components.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.profile,
    this.reviewLabel = '내 후기',
    this.savedLabel = '찜 목록',
  });

  final UserProfile profile;
  final String reviewLabel;
  final String savedLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MetricTile(
          label: reviewLabel,
          value: '${profile.reviewCount}',
          icon: LucideIcons.star,
        ),
        12.widthBox,
        MetricTile(
          label: savedLabel,
          value: '${profile.savedCount}',
          icon: LucideIcons.bookmark,
        ),
      ],
    );
  }
}
