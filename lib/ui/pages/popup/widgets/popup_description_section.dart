import 'package:flutter/material.dart';

import 'popup_section_title_row.dart';

class PopupDescriptionSection extends StatelessWidget {
  const PopupDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupSectionTitleRow(title: '팝업 소개', action: '자세히 보기'),
        SizedBox(height: 16),
        Text(
          "도심 속의 작은 휴식처, 메종 키츠네의 '가든 팝업'이 성수동에 찾아왔습니다. 이번 팝업은 프랑스어로 '집'을 뜻하는 메종의 정체성을 담아, 따뜻한 환대의 공간을 제안합니다.",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF45474B),
            fontSize: 16,
            height: 1.625,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
