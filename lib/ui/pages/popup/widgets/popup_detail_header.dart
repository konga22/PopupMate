import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/router/app_page.dart';
import '../../../../app/theme/app_theme.dart';

class PopupDetailHeader extends StatelessWidget {
  const PopupDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.82),
      ),
      child: Row(
        children: [
          _HeaderIconButton(
            icon: LucideIcons.chevronLeft,
            onTap: () {
              if (context.canPop()) {
                context.pop();
                return;
              }
              context.goNamed(AppPage.home.name);
            },
          ),
          const Expanded(
            child: Text(
              '상세 정보',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 20,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _HeaderIconButton(icon: LucideIcons.share2, onTap: () {}),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Icon(icon, color: AppColors.ink, size: 22),
      ),
    );
  }
}
