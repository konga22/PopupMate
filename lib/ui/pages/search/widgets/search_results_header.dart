import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class SearchResultsHeader extends StatelessWidget {
  const SearchResultsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SEARCH RESULTS',
          style: TextStyle(
            color: Color(0xFF45474B),
            fontSize: 12,
            height: 1.33,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '2건의 결과',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            height: 1.43,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
