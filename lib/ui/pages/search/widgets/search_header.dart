import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/theme/app_theme.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'PopupMate',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 24,
                height: 1.33,
                letterSpacing: -0.24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Icon(LucideIcons.search, color: AppColors.ink, size: 20),
          const SizedBox(width: 16),
          Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: const Color(0xFFE5E2E2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(AppAssets.searchAvatar, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
