import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../common/app_components.dart';

class ReviewDetailInput extends StatelessWidget {
  const ReviewDetailInput({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return LabelTextField(
      label: '상세 리뷰',
      hint: '분위기나 특별했던 점은 무엇인가요?',
      controller: controller,
      icon: LucideIcons.penLine,
      maxLines: 7,
    );
  }
}
