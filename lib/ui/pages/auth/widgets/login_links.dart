import 'package:flutter/material.dart';

import 'login_design_tokens.dart';

class LoginLinks extends StatelessWidget {
  const LoginLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FooterLink(label: '비밀번호 찾기', onTap: () {}),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: 4,
            height: 4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: LoginColors.border,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        _FooterLink(label: '회원가입', onTap: () {}),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: LoginColors.body,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20 / 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
