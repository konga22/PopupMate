import 'package:flutter/material.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../services/popup/mock_popup_service.dart';
import '../../common/app_components.dart';
import 'widgets/inventory_category_filter.dart';
import 'widgets/inventory_product_list.dart';
import 'widgets/inventory_search_field.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  String _category = '전체';

  @override
  Widget build(BuildContext context) {
    final products = MockPopupService.inventory;

    return Scaffold(
      appBar: const AppTopBar(title: '재고 현황', showBack: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const InventorySearchField(),
          16.heightBox,
          InventoryCategoryFilter(
            selected: _category,
            onSelected: (value) => setState(() => _category = value),
          ),
          24.heightBox,
          InventoryProductList(products: products),
        ],
      ),
    );
  }
}
