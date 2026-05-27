import 'package:flutter/material.dart';

import 'onboarding_design_tokens.dart';

class OnboardingLoginPrompt extends StatelessWidget {
  const OnboardingLoginPrompt({super.key, required this.onLoginTap});

  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '이미 계정이 있으신가요? ',
          style: TextStyle(
            color: OnboardingColors.muted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 20 / 14,
          ),
        ),
        GestureDetector(
          onTap: onLoginTap,
          child: const Text(
            '로그인',
            style: TextStyle(
              color: OnboardingColors.ink,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
