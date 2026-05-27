import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class SearchResultLocationRow extends StatelessWidget {
  const SearchResultLocationRow({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(LucideIcons.mapPin, color: AppColors.body, size: 13),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF45474B),
              fontSize: 14,
              height: 1.43,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
