import 'package:flutter/material.dart';

import 'onboarding_brand_label.dart';
import 'onboarding_copy.dart';
import 'onboarding_login_prompt.dart';
import 'onboarding_start_button.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.onStart,
    required this.onLoginTap,
  });

  final VoidCallback onStart;
  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OnboardingBrandLabel(),
            const Spacer(),
            const OnboardingCopy(),
            const SizedBox(height: 48),
            OnboardingStartButton(onPressed: onStart),
            const SizedBox(height: 16),
            OnboardingLoginPrompt(onLoginTap: onLoginTap),
          ],
        ),
      ),
    );
  }
}
