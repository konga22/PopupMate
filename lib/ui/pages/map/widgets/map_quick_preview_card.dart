import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/assets/app_assets.dart';
import '../../../../app/theme/app_theme.dart';

class MapQuickPreviewCard extends StatelessWidget {
  final bool saved;
  final VoidCallback onWaitingTap;
  final VoidCallback onSaveTap;

  const MapQuickPreviewCard({
    super.key,
    required this.saved,
    required this.onWaitingTap,
    required this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: OverflowBox(
                      maxWidth: 243,
                      maxHeight: 80,
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppAssets.mapPreview,
                        width: 243,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(child: _PreviewContent()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onWaitingTap,
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.ink,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '웨이팅 신청하기',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          height: 1.33,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onSaveTap,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Icon(
                      saved ? LucideIcons.heart : LucideIcons.heart,
                      color: saved ? AppColors.danger : AppColors.body,
                      fill: saved ? 1.0 : 0.0,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewContent extends StatelessWidget {
  const _PreviewContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NewBadge(),
            Flexible(
              child: Text(
                '200m away',
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF45474B),
                  fontSize: 12,
                  height: 1.33,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Aromatic Cloud Popup',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 20,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '성수동 2가 314-1',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(0xFF45474B),
            fontSize: 14,
            height: 1.43,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: AppColors.ink.withValues(alpha: 0.2)),
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          color: AppColors.ink,
          fontSize: 12,
          height: 1.33,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
