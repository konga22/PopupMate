import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';

class MapSearchBar extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  final VoidCallback? onFilterTap;

  const MapSearchBar({super.key, this.onSearch, this.onFilterTap});

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 17),
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
      child: Row(
        children: [
          const Icon(LucideIcons.search, size: 20, color: AppColors.body),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearch,
              decoration: const InputDecoration(
                hintText: '성수동 팝업스토어 검색',
                hintStyle: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onFilterTap,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                LucideIcons.slidersHorizontal,
                size: 20,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
