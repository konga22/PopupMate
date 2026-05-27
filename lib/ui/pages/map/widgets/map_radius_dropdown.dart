import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class MapRadiusDropdown extends StatelessWidget {
  const MapRadiusDropdown({
    super.key,
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
          final optionLabel = option == 1000 ? '1km' : '${option}m';

          return PopupMenuItem<int>(
            value: option,
            height: 36,
            padding: EdgeInsets.zero,
            child: _RadiusOption(label: optionLabel, selected: isSelected),
          );
        }).toList();
      },
      child: _RadiusButton(label: label),
    );
  }
}

class _RadiusOption extends StatelessWidget {
  const _RadiusOption({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color:
          selected
              ? AppColors.surfaceAlt.withValues(alpha: 0.5)
              : Colors.transparent,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: selected ? AppColors.ink : const Color(0xFF1C1B1C),
          fontSize: 14,
          height: 1.43,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _RadiusButton extends StatelessWidget {
  const _RadiusButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
