import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import 'loading_brand_mark.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingBrandMark(),
          SizedBox(height: 28),
          Text(
            'PopupMate',
            style: TextStyle(
              color: AppColors.ink,
              fontFamily: 'MoveSans',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text('초기화 중...', style: TextStyle(color: AppColors.muted)),
        ],
      ),
    );
  }
}
