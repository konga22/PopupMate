import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';

class HomeHeroBackground extends StatelessWidget {
  const HomeHeroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppAssets.homeHero,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x001C1B1C), Color(0x1A1C1B1C), Color(0xCC1C1B1C)],
              stops: [0.0, 0.52, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
