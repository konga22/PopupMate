import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../common/app_components.dart';

class CommunityFilterSheet extends StatelessWidget {
  const CommunityFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: '필터 설정', caption: '정렬'),
          16.heightBox,
          FilterChipBar(
            labels: const ['최신순', '인기순', '댓글순'],
            selected: '최신순',
            onSelected: (_) {},
          ),
          20.heightBox,
          const Text('지역', style: TextStyle(fontWeight: FontWeight.w800)),
          10.heightBox,
          FilterChipBar(
            labels: const ['성수', '연남', '강남', '한남'],
            selected: '성수',
            onSelected: (_) {},
          ),
          24.heightBox,
          PrimaryButton(
            label: '적용하기',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
