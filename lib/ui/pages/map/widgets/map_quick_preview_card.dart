import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'map_preview_actions.dart';
import 'map_preview_content.dart';
import 'map_preview_image.dart';

class MapQuickPreviewCard extends StatelessWidget {
  final bool saved;
  final VoidCallback onWaitingTap;
  final VoidCallback onSaveTap;

  const MapQuickPreviewCard({
    super.key,
    required this.saved,
    required this.onWaitingTap,
    required this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MapPreviewImage(),
                const SizedBox(width: 16),
                const Expanded(child: MapPreviewContent()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: MapPreviewActions(
              saved: saved,
              onWaitingTap: onWaitingTap,
              onSaveTap: onSaveTap,
            ),
          ),
        ],
      ),
    );
  }
}
