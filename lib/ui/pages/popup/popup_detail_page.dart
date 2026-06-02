import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../common/app_components.dart';
import 'widgets/popup_detail_header.dart';
import 'widgets/popup_detail_hero.dart';
import 'widgets/popup_detail_info_content.dart';
import 'widgets/popup_placeholder_content.dart';
import 'widgets/popup_waitlist_button.dart';

class PopupDetailPage extends StatefulWidget {
  const PopupDetailPage({super.key, required this.popupId});

  final String popupId;

  @override
  State<PopupDetailPage> createState() => _PopupDetailPageState();
}

class _PopupDetailPageState extends State<PopupDetailPage> {
  String _tab = '정보';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 132),
                children: [
                  PopupDetailHero(
                    selectedTab: _tab,
                    onTabSelected: (tab) => setState(() => _tab = tab),
                  ),
                  if (_tab == '정보') const PopupDetailInfoContent(),
                  if (_tab == '커뮤니티') const PopupDetailCommunityContent(),
                  if (_tab == '리뷰') const PopupDetailReviewContent(),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: PopupDetailHeader(),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: -4,
              child: PopupWaitlistButton(
                onTap: () => context.pushNamed(AppPage.waiting.name),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.home),
    );
  }
}
