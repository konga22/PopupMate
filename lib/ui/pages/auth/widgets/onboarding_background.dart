import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.onboardingBackground,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00FCF8F9),
                  Color(0x33FCF8F9),
                  Color(0xE6FCF8F9),
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
