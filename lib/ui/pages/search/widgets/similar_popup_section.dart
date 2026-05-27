import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import 'similar_popup_card.dart';

class SimilarPopupSection extends StatelessWidget {
  const SimilarPopupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '검색 결과 유사 팝업',
          style: TextStyle(
            color: Color(0xFF1C1B1C),
            fontSize: 24,
            height: 1.33,
            letterSpacing: -0.24,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: SimilarPopupCard(
                image: AppAssets.searchSimilarOne,
                caption: '브랜드 위크',
                title: '미니멀리스트 쇼룸',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SimilarPopupCard(
                image: AppAssets.searchSimilarTwo,
                caption: '라이프스타일',
                title: '어반 네이처 전시',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
