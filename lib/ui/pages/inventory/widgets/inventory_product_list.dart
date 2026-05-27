import 'package:flutter/material.dart';

import '../../../../models/inventory_models.dart';
import 'inventory_product_tile.dart';

class InventoryProductList extends StatelessWidget {
  const InventoryProductList({super.key, required this.products});

  final List<InventoryProduct> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...products.map((product) => InventoryProductTile(product: product)),
      ],
    );
  }
}
