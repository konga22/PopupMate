import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_page.dart';
import 'home_hero_background.dart';
import 'home_hero_content.dart';
import 'home_hero_indicator.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.pushNamed(
            AppPage.popupDetail.name,
            pathParameters: {'id': 'seongsu-modern-terrace'},
          ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const HomeHeroBackground(),
            const Positioned(
              left: 20,
              right: 20,
              bottom: 52,
              child: HomeHeroContent(),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: HomeHeroIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
