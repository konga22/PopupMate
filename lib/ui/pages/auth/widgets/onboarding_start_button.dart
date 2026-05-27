import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'onboarding_design_tokens.dart';

class OnboardingStartButton extends StatelessWidget {
  const OnboardingStartButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: OnboardingColors.ink,
          foregroundColor: Colors.white,
          elevation: 20,
          shadowColor: Colors.black.withValues(alpha: 0.25),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 28 / 20,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('시작하기'),
            SizedBox(width: 8),
            Icon(LucideIcons.arrowRight, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }
}
