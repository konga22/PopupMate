import 'package:flutter/material.dart';

class HomeHeroContent extends StatelessWidget {
  const HomeHeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
    );
  }
}
