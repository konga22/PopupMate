import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'map_preview_badge.dart';

class MapPreviewContent extends StatelessWidget {
  const MapPreviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MapPreviewBadge(),
            Flexible(
              child: Text(
                '200m away',
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
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
        SizedBox(height: 4),
        Text(
          'Aromatic Cloud Popup',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 20,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '성수동 2가 314-1',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
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
