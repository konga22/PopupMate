import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';

class FilterChipBar extends StatelessWidget {
  const FilterChipBar({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });

  final List<String> labels;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            labels.map((label) {
              final isSelected = label == selected;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) => onSelected(label),
                  selectedColor: AppColors.ink,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.body,
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor: AppColors.surface,
                  side: const BorderSide(color: AppColors.softBorder),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
