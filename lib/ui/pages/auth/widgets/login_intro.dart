import 'package:flutter/material.dart';

import 'login_design_tokens.dart';

class LoginIntro extends StatelessWidget {
  const LoginIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반갑습니다!',
          style: TextStyle(
            color: LoginColors.ink,
            fontSize: 32,
            fontWeight: FontWeight.w500,
            height: 40 / 32,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 328,
          child: Text(
            '로그인하여 당신만의 팝업 큐레이션을 시작해보세요.',
            style: TextStyle(
              color: LoginColors.body,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 24 / 16,
            ),
          ),
        ),
      ],
    );
  }
}
