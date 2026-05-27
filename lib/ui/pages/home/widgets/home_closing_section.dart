import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import 'home_closing_card.dart';
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
          HomeClosingCard(
            image: AppAssets.homeClosingOne,
            dday: 'D-2',
            area: '성수',
            title: '나이키 SNKRS 데이',
            progress: 0.85,
            urgent: false,
          ),
          SizedBox(height: 12),
          HomeClosingCard(
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
