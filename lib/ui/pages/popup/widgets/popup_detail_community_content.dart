import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'popup_placeholder_panel.dart';

class PopupDetailCommunityContent extends StatelessWidget {
  const PopupDetailCommunityContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        children: [
          PopupPlaceholderPanel(
            icon: LucideIcons.messageCircle,
            title: '커뮤니티 준비 중',
            body: '방문자들의 질문과 팁을 모아볼 수 있는 영역입니다.',
          ),
        ],
      ),
    );
  }
}
