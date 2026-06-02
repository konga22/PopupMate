import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../common/app_components.dart';
import 'permission_item.dart';

class PermissionTile extends StatelessWidget {
  const PermissionTile({super.key, required this.item});

  final PermissionItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: AppColors.ink),
          14.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    8.widthBox,
                    StatusBadge(label: item.badge),
                  ],
                ),
                8.heightBox,
                Text(
                  item.message,
                  style: const TextStyle(color: AppColors.body, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
