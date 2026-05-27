import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class PopupDetailCommunityContent extends StatelessWidget {
  const PopupDetailCommunityContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        children: [
          _SimplePanel(
            icon: LucideIcons.messageCircle,
            title: '커뮤니티 준비 중',
            body: '방문자들의 질문과 팁을 모아볼 수 있는 영역입니다.',
          ),
        ],
      ),
    );
  }
}

class PopupDetailReviewContent extends StatelessWidget {
  const PopupDetailReviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
      child: Column(
        children: [
          _SimplePanel(
            icon: LucideIcons.star,
            title: '리뷰 준비 중',
            body: '팝업 방문 후 남긴 리뷰와 별점을 보여줄 예정입니다.',
          ),
        ],
      ),
    );
  }
}

class _SimplePanel extends StatelessWidget {
  const _SimplePanel({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.ink, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.body, height: 1.5),
          ),
        ],
      ),
    );
  }
}
