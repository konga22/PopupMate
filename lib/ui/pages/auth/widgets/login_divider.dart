import 'package:flutter/material.dart';

import 'login_design_tokens.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: LoginColors.border, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: LoginColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 16 / 12,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(child: Divider(color: LoginColors.border, height: 1)),
      ],
    );
  }
}
