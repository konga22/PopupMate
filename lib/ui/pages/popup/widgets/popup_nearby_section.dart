import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/theme/app_theme.dart';
import 'popup_section_title_row.dart';

class PopupNearbySection extends StatelessWidget {
  const PopupNearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PopupSectionTitleRow(title: '주변 추천 상권', action: 'SEE ALL'),
        const SizedBox(height: 16),
        SizedBox(
          height: 282,
          child: ListView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            children: const [
              _NearbyCard(
                image: AppAssets.detailNearbyCafe,
                badge: 'CAFÉ',
                title: '쎈느 Scène',
                caption: '도보 3분 · 시그니처 베이커리',
              ),
              SizedBox(width: 24),
              _NearbyCard(
                image: AppAssets.detailNearbyRestaurant,
                badge: 'DINING',
                title: '누데이크 성수',
                caption: '도보 5분 · 아티스틱 디저트 카페',
              ),
              SizedBox(width: 24),
              _NearbyCard(
                image: AppAssets.searchSimilarTwo,
                badge: 'SHOP',
                title: '엠프티 EMPTY',
                caption: '도보 2분 · 셀렉트 패션 스토어',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NearbyCard extends StatelessWidget {
  const _NearbyCard({
    required this.image,
    required this.badge,
    required this.title,
    required this.caption,
  });

  final String image;
  final String badge;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.asset(image, width: 280, height: 208, fit: BoxFit.cover),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Color(0xFF1C1B1C),
                        fontSize: 10,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF45474B),
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
