import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/mock_models.dart';
import 'profile_avatar.dart';

class ProfileDetailHeader extends StatelessWidget {
  const ProfileDetailHeader({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileAvatar(radius: 52, iconSize: 46),
        18.heightBox,
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          profile.handle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.muted),
        ),
        12.heightBox,
        Text(
          profile.bio,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.body, height: 1.5),
        ),
      ],
    );
  }
}
