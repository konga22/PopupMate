import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import 'permission_item.dart';
import 'permission_tile.dart';

class PermissionList extends StatelessWidget {
  const PermissionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in permissionItems) ...[
          PermissionTile(item: item),
          if (item != permissionItems.last) 14.heightBox,
        ],
      ],
    );
  }
}
