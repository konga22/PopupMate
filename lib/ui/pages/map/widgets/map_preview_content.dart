import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../models/popup_models.dart';
import 'map_preview_badge.dart';

class MapPreviewContent extends StatelessWidget {
  final Popup popup;

  const MapPreviewContent({super.key, required this.popup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MapPreviewBadge(
              label: switch (popup.status) {
                PopupStatus.openingSoon => '오픈예정',
                PopupStatus.inProgress => popup.heroLabel.isNotEmpty ? popup.heroLabel : '진행중',
                PopupStatus.ended => '종료',
              },
            ),
            Flexible(
              child: Text(
                popup.distance,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF45474B),
                  fontSize: 12,
                  height: 1.33,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          popup.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 20,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          popup.address,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF45474B),
            fontSize: 14,
            height: 1.43,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
