import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class PermissionNotice extends StatelessWidget {
  const PermissionNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '* 설정 > PopupMate 앱 설정에서 언제든지 권한을 변경할 수 있습니다.',
      style: TextStyle(color: AppColors.muted, fontSize: 12),
    );
  }
}
