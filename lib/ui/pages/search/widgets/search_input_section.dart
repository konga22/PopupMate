import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class SearchInputSection extends StatelessWidget {
  const SearchInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 47,
            padding: const EdgeInsets.fromLTRB(13, 0, 12, 0),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F3F3),
              border: Border.all(color: const Color(0xFF76777B)),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    '성수 팝업스토어',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF1C1B1C),
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(LucideIcons.search, color: AppColors.body, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(
            LucideIcons.slidersHorizontal,
            color: AppColors.ink,
            size: 20,
          ),
        ),
      ],
    );
  }
}
