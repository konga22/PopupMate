import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/assets/app_assets.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
import 'widgets/search_header.dart';
import 'widgets/search_input_section.dart';
import 'widgets/search_result_card.dart';
import 'widgets/search_results_header.dart';
import 'widgets/similar_popup_section.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            const SearchHeader(),
            const SizedBox(height: 18),
            const SearchInputSection(),
            const SizedBox(height: 32),
            const SearchResultsHeader(),
            const SizedBox(height: 16),
            SearchResultCard(
              title: '메종 키츠네 가든 팝업',
              address: '서울특별시 성동구 연무장길 12',
              badge: 'D-4',
              image: AppAssets.searchResultExterior,
              imageAlignment: Alignment.topCenter,
              onTap:
                  () => context.pushNamed(
                    AppPage.popupDetail.name,
                    pathParameters: {'id': 'maison-kitsune'},
                  ),
            ),
            const SizedBox(height: 32),
            SearchResultCard(
              title: '오브제 아트 하우스',
              address: '서울특별시 성동구 아차산로 55',
              badge: '예약중',
              image: AppAssets.searchResultInterior,
              imageAlignment: Alignment.center,
              onTap:
                  () => context.pushNamed(
                    AppPage.popupDetail.name,
                    pathParameters: {'id': 'object-house'},
                  ),
            ),
            const SizedBox(height: 48),
            const SimilarPopupSection(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.search),
    );
  }
}
