import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'login_design_tokens.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            const Text(
              'PopupMate',
              style: TextStyle(
                color: LoginColors.title,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 32 / 24,
                letterSpacing: -0.24,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: onClose,
              icon: const Icon(
                LucideIcons.x,
                color: LoginColors.title,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
