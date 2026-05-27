import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../common/app_components.dart';

const profileAccountMenuLabels = [
  '이메일 & 개인 정보',
  '결제 수단 관리',
  '보안 설정',
  '도움말',
  '약관 및 정책',
];

class ProfileAccountSection extends StatelessWidget {
  const ProfileAccountSection({super.key, required this.onItemTap});

  final ValueChanged<String> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '계정 정보'),
        12.heightBox,
        ...profileAccountMenuLabels.map(
          (label) => ListTile(
            tileColor: AppColors.surface,
            title: Text(label),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () => onItemTap(label),
          ),
        ),
      ],
    );
  }
}
