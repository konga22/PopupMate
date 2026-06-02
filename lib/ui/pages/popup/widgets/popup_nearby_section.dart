import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import 'popup_nearby_card.dart';
import 'popup_nearby_place.dart';
import 'popup_section_title_row.dart';

class PopupNearbySection extends StatelessWidget {
  const PopupNearbySection({super.key});

  static const _places = [
    PopupNearbyPlace(
      image: AppAssets.detailNearbyCafe,
      badge: 'CAFÉ',
      title: '쎈느 Scène',
      caption: '도보 3분 · 시그니처 베이커리',
    ),
    PopupNearbyPlace(
      image: AppAssets.detailNearbyRestaurant,
      badge: 'DINING',
      title: '누데이크 성수',
      caption: '도보 5분 · 아티스틱 디저트 카페',
    ),
    PopupNearbyPlace(
      image: AppAssets.searchSimilarTwo,
      badge: 'SHOP',
      title: '엠프티 EMPTY',
      caption: '도보 2분 · 셀렉트 패션 스토어',
    ),
  ];

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
            children: [
              for (var index = 0; index < _places.length; index += 1) ...[
                PopupNearbyCard(place: _places[index]),
                if (index != _places.length - 1) const SizedBox(width: 24),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
