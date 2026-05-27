import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/mock_models.dart';
import '../../../common/app_components.dart';

class WaitingStatusSummaryCard extends StatelessWidget {
  const WaitingStatusSummaryCard({super.key, required this.waiting});

  final WaitingStatus waiting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatusBadge(label: 'CURRENT STATUS'),
          24.heightBox,
          Text(
            '${waiting.estimatedMinutes ~/ 2}분 후 당신의 차례입니다',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'MoveSans',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 1.18,
            ),
          ),
          12.heightBox,
          Text(
            '대기 번호: ${waiting.myNumber}번 (현재 ${waiting.currentNumber}번 입장 중)',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
