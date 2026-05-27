import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../common/app_components.dart';

class ReviewTargetHeader extends StatelessWidget {
  const ReviewTargetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusBadge(label: '방문 완료'),
        12.heightBox,
        const Text(
          '성수동 에디토리얼 팝업',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
