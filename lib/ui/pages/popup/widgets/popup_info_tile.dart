import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class PopupInfoTile extends StatelessWidget {
  const PopupInfoTile({
    super.key,
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
