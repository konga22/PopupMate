import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'home_design_tokens.dart';

class HomeFloatingReportButton extends StatelessWidget {
  const HomeFloatingReportButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: HomeColors.title,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 50,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        child: const Center(
          child: Icon(LucideIcons.plus, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
