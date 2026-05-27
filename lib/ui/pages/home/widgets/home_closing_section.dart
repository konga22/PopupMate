import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import 'home_design_tokens.dart';

class HomeClosingSection extends StatelessWidget {
  const HomeClosingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '종료 임박 팝업',
            style: TextStyle(
              color: HomeColors.ink,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '놓치면 아쉬운 이번 주 마감 팝업',
            style: TextStyle(
              color: HomeColors.body,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
          SizedBox(height: 16),
          _ClosingCard(
            image: AppAssets.homeClosingOne,
            dday: 'D-2',
            area: '성수',
            title: '나이키 SNKRS 데이',
            progress: 0.85,
            urgent: false,
          ),
          SizedBox(height: 12),
          _ClosingCard(
            image: AppAssets.homeClosingTwo,
            dday: 'D-1',
            area: '한남',
            title: '블루보틀 홀리데이 마켓',
            progress: 0.95,
            urgent: true,
          ),
        ],
      ),
    );
  }
}

class _ClosingCard extends StatelessWidget {
  const _ClosingCard({
    required this.image,
    required this.dday,
    required this.area,
    required this.title,
    required this.progress,
    required this.urgent,
  });

  final String image;
  final String dday;
  final String area;
  final String title;
  final double progress;
  final bool urgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HomeColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: HomeColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dday,
                      style: const TextStyle(
                        color: HomeColors.danger,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      area,
                      style: const TextStyle(
                        color: HomeColors.body,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 18 / 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: HomeColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    value: progress,
                    backgroundColor: HomeColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      urgent ? HomeColors.danger : HomeColors.title,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
