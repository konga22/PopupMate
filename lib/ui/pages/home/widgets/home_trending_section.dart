import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/router/app_page.dart';
import 'home_design_tokens.dart';
import 'home_trending_card.dart';

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
                HomeTrendingCard(
                  image: AppAssets.homeTrendingOne,
                  title: '메종 키츠네 카페 팝업',
                  subtitle: '가로수길 | 11.20 - 12.15',
                ),
                SizedBox(width: 16),
                HomeTrendingCard(
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
