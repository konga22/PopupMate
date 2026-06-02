import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/router/app_page.dart';
import 'home_design_tokens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            const Text(
              'PopupMate',
              style: TextStyle(
                color: HomeColors.title,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                height: 32 / 24,
                letterSpacing: -0.24,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.goNamed(AppPage.search.name),
              child: const SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: Icon(
                    LucideIcons.search,
                    color: HomeColors.title,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => context.goNamed(AppPage.profile.name),
              child: Container(
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFE0E2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: HomeColors.border),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.asset(AppAssets.homeProfile, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
