import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class MapFloatingControls extends StatelessWidget {
  final String radiusLabel;
  final List<int> radiusOptions;
  final int selectedRadius;
  final ValueChanged<int> onRadiusSelected;
  final VoidCallback onCurrentLocationTap;

  const MapFloatingControls({
    super.key,
    required this.radiusLabel,
    required this.radiusOptions,
    required this.selectedRadius,
    required this.onRadiusSelected,
    required this.onCurrentLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _RadiusDropdown(
          label: '$radiusLabel 반경',
          options: radiusOptions,
          selectedRadius: selectedRadius,
          onSelected: onRadiusSelected,
        ),
        _CurrentLocationButton(onTap: onCurrentLocationTap),
      ],
    );
  }
}

class _RadiusDropdown extends StatelessWidget {
  const _RadiusDropdown({
    required this.label,
    required this.options,
    required this.selectedRadius,
    required this.onSelected,
  });

  final String label;
  final List<int> options;
  final int selectedRadius;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: selectedRadius,
      onSelected: onSelected,
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      color: Colors.white,
      elevation: 15,
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return options.map((option) {
          final isSelected = option == selectedRadius;
          final optionLabel = '${option}m';

          return PopupMenuItem<int>(
            value: option,
            height: 36,
            padding: EdgeInsets.zero,
            child: Container(
              height: 36,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: isSelected
                  ? AppColors.surfaceAlt.withValues(alpha: 0.5)
                  : Colors.transparent,
              child: Text(
                optionLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? AppColors.ink : const Color(0xFF1C1B1C),
                  fontSize: 14,
                  height: 1.43,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1.33,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(LucideIcons.chevronDown, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }
}

class _CurrentLocationButton extends StatelessWidget {
  const _CurrentLocationButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: const Icon(
          LucideIcons.locateFixed,
          color: AppColors.ink,
          size: 22,
        ),
      ),
    );
  }
}
