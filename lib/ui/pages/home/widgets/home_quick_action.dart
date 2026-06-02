import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_page.dart';
import 'home_design_tokens.dart';

class HomeQuickAction extends StatelessWidget {
  const HomeQuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final AppPage route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(route.name),
      child: SizedBox(
        width: 78.5,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: HomeColors.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HomeColors.border),
              ),
              child: Center(
                child: Icon(icon, color: HomeColors.title, size: 30),
              ),
            ),
            const SizedBox(height: 7.5),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: HomeColors.body,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 12.5 / 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
