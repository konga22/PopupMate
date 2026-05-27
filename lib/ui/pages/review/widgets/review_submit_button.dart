import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../common/app_components.dart';

class ReviewSubmitButton extends StatelessWidget {
  const ReviewSubmitButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: '리뷰 등록하고 배지 받기',
      icon: LucideIcons.badgeCheck,
      onPressed: onPressed,
    );
  }
}
