import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class PopupSectionTitleRow extends StatelessWidget {
  const PopupSectionTitleRow({
    super.key,
    required this.title,
    required this.action,
    this.onTap,
  });

  final String title;
  final String action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 24,
              height: 1.33,
              letterSpacing: -0.24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  action,
                  style: TextStyle(
                    color:
                        action == 'SEE ALL' ? AppColors.border : AppColors.ink,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (action != 'SEE ALL') ...[
                  const SizedBox(width: 4),
                  const Icon(
                    LucideIcons.chevronRight,
                    color: AppColors.ink,
                    size: 16,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
