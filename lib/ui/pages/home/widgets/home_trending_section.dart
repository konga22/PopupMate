import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/router/app_page.dart';
import 'home_design_tokens.dart';

class HomeTrendingSection extends StatelessWidget {
  const HomeTrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '지금 뜨는 팝업',
                        style: TextStyle(
                          color: HomeColors.ink,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          height: 32 / 24,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '실시간 가장 핫한 장소들을 확인하세요',
                        style: TextStyle(
                          color: HomeColors.body,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.goNamed(AppPage.search.name),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '전체보기',
                      style: TextStyle(
                        color: HomeColors.body,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 416,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                _TrendingCard(
                  image: AppAssets.homeTrendingOne,
                  title: '메종 키츠네 카페 팝업',
                  subtitle: '가로수길 | 11.20 - 12.15',
                ),
                SizedBox(width: 16),
                _TrendingCard(
                  image: AppAssets.homeTrendingTwo,
                  title: '아트토이 서울 한정전',
                  subtitle: '성수 | 11.18 - 12.03',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.pushNamed(
            AppPage.popupDetail.name,
            pathParameters: {'id': 'maison-kitsune'},
          ),
      child: SizedBox(
        width: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    width: 360,
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    height: 26,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.flame,
                          color: HomeColors.danger,
                          size: 13,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'HOT',
                          style: TextStyle(
                            color: HomeColors.ink,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 18 / 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: HomeColors.ink,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                height: 28 / 20,
              ),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: HomeColors.body,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
