import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../models/mock_models.dart';
import '../../../common/app_components.dart';

class InventoryProductTile extends StatelessWidget {
  const InventoryProductTile({super.key, required this.product});

  final InventoryProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        tileColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.softBorder),
        ),
        leading: const Icon(LucideIcons.package),
        title: Text(product.name),
        subtitle: Text('${product.category} · ${product.price}'),
        trailing: StatusBadge(
          label: product.status,
          tone: _inventoryStatusTone(product.status),
        ),
      ),
    );
  }
}

BadgeTone _inventoryStatusTone(String status) {
  if (status == '품절') return BadgeTone.danger;
  if (status == '품절 임박') return BadgeTone.warning;
  return BadgeTone.success;
}
