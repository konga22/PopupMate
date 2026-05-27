import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/router/app_page.dart';
import '../../../../app/theme/app_theme.dart';
import 'popup_nearby_section.dart';
import 'popup_section_title_row.dart';

class PopupDetailInfoContent extends StatelessWidget {
  const PopupDetailInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoTile(
            icon: LucideIcons.ticket,
            label: '입장료',
            value: '무료 (사전예약 권장)',
          ),
          SizedBox(height: 12),
          _InfoTile(
            icon: LucideIcons.clock,
            label: '운영시간',
            value: '11:00 - 20:00',
            strong: true,
          ),
          SizedBox(height: 12),
          _InfoTile(
            icon: LucideIcons.timer,
            label: '예상 대기 시간',
            value: '약 45분 예상',
          ),
          SizedBox(height: 72),
          _DescriptionSection(),
          SizedBox(height: 48),
          _DetailMapSection(),
          SizedBox(height: 48),
          PopupNearbySection(),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.strong = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.ink.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.ink, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF76777B),
                    fontSize: 12,
                    height: 1.33,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF1C1B1C),
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupSectionTitleRow(title: '팝업 소개', action: '자세히 보기'),
        SizedBox(height: 16),
        Text(
          "도심 속의 작은 휴식처, 메종 키츠네의 '가든 팝업'이 성수동에 찾아왔습니다. 이번 팝업은 프랑스어로 '집'을 뜻하는 메종의 정체성을 담아, 따뜻한 환대의 공간을 제안합니다.",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF45474B),
            fontSize: 16,
            height: 1.625,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DetailMapSection extends StatelessWidget {
  const _DetailMapSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupSectionTitleRow(
          title: '찾아오시는 길',
          action: '지도 확대',
          onTap: () => context.goNamed(AppPage.map.name),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAssets.detailMap,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.ink,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.mapPin, color: Colors.white, size: 17),
                        SizedBox(width: 8),
                        Text(
                          '메종 키츠네 가든',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
