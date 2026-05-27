import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/router/app_page.dart';

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
                  colors: [
                    Color(0x001C1B1C),
                    Color(0x1A1C1B1C),
                    Color(0xCC1C1B1C),
                  ],
                  stops: [0.0, 0.52, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 52,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF50535A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '성수동 팝업:\n더 모던 테라스',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      height: 40 / 32,
                      letterSpacing: -0.64,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '2023.11.24 - 12.10 | 성수역 3번 출구',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HeroDot(active: true),
                  _HeroDot(),
                  _HeroDot(),
                  _HeroDot(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroDot extends StatelessWidget {
  const _HeroDot({this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: active ? 1 : 0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}
