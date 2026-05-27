import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'popup_placeholder_panel.dart';

class PopupDetailReviewContent extends StatelessWidget {
  const PopupDetailReviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        children: [
          PopupPlaceholderPanel(
            icon: LucideIcons.star,
            title: '리뷰 준비 중',
            body: '팝업 방문 후 남긴 리뷰와 별점을 보여줄 예정입니다.',
          ),
        ],
      ),
    );
  }
}
