import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'popup_description_section.dart';
import 'popup_detail_map_section.dart';
import 'popup_info_tile.dart';
import 'popup_nearby_section.dart';

class PopupDetailInfoContent extends StatelessWidget {
  const PopupDetailInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopupInfoTile(
            icon: LucideIcons.ticket,
            label: '입장료',
            value: '무료 (사전예약 권장)',
          ),
          SizedBox(height: 12),
          PopupInfoTile(
            icon: LucideIcons.clock,
            label: '운영시간',
            value: '11:00 - 20:00',
            strong: true,
          ),
          SizedBox(height: 12),
          PopupInfoTile(
            icon: LucideIcons.timer,
            label: '예상 대기 시간',
            value: '약 45분 예상',
          ),
          SizedBox(height: 72),
          PopupDescriptionSection(),
          SizedBox(height: 48),
          PopupDetailMapSection(),
          SizedBox(height: 48),
          PopupNearbySection(),
        ],
      ),
    );
  }
}
