import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class PermissionIntro extends StatelessWidget {
  const PermissionIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '편리한 이용을 위해\n권한을 허용해주세요',
          style: TextStyle(
            color: AppColors.ink,
            fontFamily: 'MoveSans',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '선택 권한은 허용하지 않아도 서비스를 이용할 수 있습니다.',
          style: TextStyle(color: AppColors.body, height: 1.5),
        ),
      ],
    );
  }
}
