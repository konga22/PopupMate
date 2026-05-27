import 'package:flutter/material.dart';

import '../../../common/app_components.dart';

const inventoryCategoryLabels = ['전체', '의류', '액세서리', '리빙', '여유', '품절 임박', '품절'];

class InventoryCategoryFilter extends StatelessWidget {
  const InventoryCategoryFilter({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChipBar(
      labels: inventoryCategoryLabels,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
