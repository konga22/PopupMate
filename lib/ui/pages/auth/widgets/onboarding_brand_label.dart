import 'package:flutter/material.dart';

import 'onboarding_design_tokens.dart';

class OnboardingBrandLabel extends StatelessWidget {
  const OnboardingBrandLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'POPMATE',
      style: TextStyle(
        color: OnboardingColors.ink,
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 32 / 24,
        letterSpacing: 0,
      ),
    );
  }
}
