import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class MapPreviewWaitingButton extends StatelessWidget {
  const MapPreviewWaitingButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          '웨이팅 신청하기',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.33,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
