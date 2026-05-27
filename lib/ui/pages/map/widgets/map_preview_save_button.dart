import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class MapPreviewSaveButton extends StatelessWidget {
  const MapPreviewSaveButton({
    super.key,
    required this.saved,
    required this.onTap,
  });

  final bool saved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(
          saved ? Icons.favorite : LucideIcons.heart,
          color: saved ? const Color(0xFFDCC5CF) : AppColors.body,
          size: 22,
        ),
      ),
    );
  }
}
