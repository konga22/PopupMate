import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.radius = 36, this.iconSize = 34});

  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceAlt,
      child: Icon(LucideIcons.user, color: AppColors.ink, size: iconSize),
    );
  }
}
