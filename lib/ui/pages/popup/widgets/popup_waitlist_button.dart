import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class PopupWaitlistButton extends StatelessWidget {
  const PopupWaitlistButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 25,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.calendarCheck, color: Colors.white, size: 20),
            SizedBox(width: 16),
            Text(
              '웨이팅 예약하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
