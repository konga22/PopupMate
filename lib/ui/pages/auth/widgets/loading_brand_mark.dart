import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class LoadingBrandMark extends StatelessWidget {
  const LoadingBrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      width: 132,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A393C43),
            blurRadius: 40,
            offset: Offset(0, 22),
          ),
        ],
      ),
      child: const Icon(LucideIcons.store, color: AppColors.ink, size: 58),
    );
  }
}
