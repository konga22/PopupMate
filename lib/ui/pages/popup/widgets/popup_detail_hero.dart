import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/theme/app_theme.dart';

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
          const Positioned(left: 20, right: 20, top: 318, child: _TitleCard()),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _DetailTabs(
              selectedTab: selectedTab,
              onSelected: onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(33),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDFE0E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'FASHION & LIFESTYLE',
              style: TextStyle(
                color: Color(0xFF616365),
                fontSize: 12,
                height: 1.33,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '메종 키츠네 가든 팝\n업',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 32,
              height: 1.25,
              letterSpacing: -0.64,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(LucideIcons.mapPin, color: Color(0xFF45474B), size: 15),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '성동구 성수동 연무장길 12',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF45474B),
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailTabs extends StatelessWidget {
  const _DetailTabs({required this.selectedTab, required this.onSelected});

  final String selectedTab;
  final ValueChanged<String> onSelected;

  static const _tabs = ['정보', '커뮤니티', '리뷰'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children:
            _tabs.map((tab) {
              final selected = tab == selectedTab;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelected(tab),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 18),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selected ? AppColors.ink : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            selected ? AppColors.ink : const Color(0xFF76777B),
                        fontSize: 20,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
