import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class PopupDetailTitleCard extends StatelessWidget {
  const PopupDetailTitleCard({super.key});

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
