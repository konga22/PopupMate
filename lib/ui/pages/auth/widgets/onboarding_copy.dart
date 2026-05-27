import 'package:flutter/material.dart';

import 'onboarding_design_tokens.dart';

class OnboardingCopy extends StatelessWidget {
  const OnboardingCopy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '내 취향에 딱 맞는\n팝업 탐색',
          style: TextStyle(
            color: OnboardingColors.ink,
            fontSize: 36,
            fontWeight: FontWeight.w500,
            height: 44 / 36,
            letterSpacing: 0,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 310,
          child: Text(
            '웨이팅 시간 예측부터\n맞춤형 큐레이션까지\n당신만의 감각적인 경험을 제안합니다',
            style: TextStyle(
              color: OnboardingColors.body,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 27.63 / 17,
            ),
          ),
        ),
      ],
    );
  }
}
