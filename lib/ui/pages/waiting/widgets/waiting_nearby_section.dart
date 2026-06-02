import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../common/app_components.dart';

const waitingNearbyPlaces = [
  '카페 오라 (Cafe Ora) · 도보 3분 · 4.8',
  '오브젝트 성수 · 소품샵 · 도보 5분',
  '아크앤북 · 독서 공간 · 도보 7분',
  'GS25 프리미엄 · 도보 1분 · 24시간',
];

class WaitingNearbySection extends StatelessWidget {
  const WaitingNearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '주변 탐색', caption: '서울시 성수동'),
        16.heightBox,
        ...waitingNearbyPlaces.map((label) => WaitingNearbyPlaceTile(label)),
      ],
    );
  }
}

class WaitingNearbyPlaceTile extends StatelessWidget {
  const WaitingNearbyPlaceTile(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        tileColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.softBorder),
        ),
        leading: const Icon(LucideIcons.mapPin),
        title: Text(label),
      ),
    );
  }
}
