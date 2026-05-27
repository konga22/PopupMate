import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class InventorySearchField extends StatelessWidget {
  const InventorySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(LucideIcons.search),
        hintText: '상품명을 입력하세요',
      ),
    );
  }
}
