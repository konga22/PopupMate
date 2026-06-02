import 'package:flutter/material.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/theme/app_theme.dart';
import 'popup_detail_tabs.dart';
import 'popup_detail_title_card.dart';

class PopupDetailHero extends StatelessWidget {
  const PopupDetailHero({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final String selectedTab;
  final ValueChanged<String> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 360,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAssets.detailHero,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00FCF8F9), AppColors.background],
                      stops: [0.68, 1],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 20,
            right: 20,
            top: 318,
            child: PopupDetailTitleCard(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PopupDetailTabs(
              selectedTab: selectedTab,
              onSelected: onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}
