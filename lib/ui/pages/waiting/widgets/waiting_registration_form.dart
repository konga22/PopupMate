import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../common/app_components.dart';
import 'waiting_people_stepper.dart';

class WaitingRegistrationForm extends StatelessWidget {
  const WaitingRegistrationForm({
    super.key,
    required this.people,
    required this.phoneController,
    required this.onDecreasePeople,
    required this.onIncreasePeople,
    required this.onSubmit,
  });

  final int people;
  final TextEditingController phoneController;
  final VoidCallback onDecreasePeople;
  final VoidCallback onIncreasePeople;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '대기 등록', caption: 'CURRENT STATUS'),
        12.heightBox,
        const Text(
          '현재 매장이 혼잡하여 웨이팅이 필요합니다.',
          style: TextStyle(color: AppColors.body),
        ),
        24.heightBox,
        WaitingPeopleStepper(
          people: people,
          onDecrease: onDecreasePeople,
          onIncrease: onIncreasePeople,
        ),
        20.heightBox,
        LabelTextField(
          label: '휴대폰 번호',
          hint: '010-0000-0000',
          controller: phoneController,
          icon: LucideIcons.phone,
        ),
        24.heightBox,
        const EmptyPlaceholder(
          title: '매장 이용 정책',
          message: '호출 후 5분 내 미입장 시 대기가 자동 취소될 수 있습니다.',
          icon: LucideIcons.shieldCheck,
        ),
        24.heightBox,
        PrimaryButton(
          label: 'Register for Waiting',
          icon: LucideIcons.send,
          onPressed: onSubmit,
        ),
      ],
    );
  }
}
