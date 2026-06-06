import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../models/popup_models.dart';

class MapFilterSheet extends StatefulWidget {
  final Set<String> initialSelectedCategories;
  final PopupStatus? initialIsOperating;
  final void Function(Set<String> categories, PopupStatus? isOperating) onApply;

  const MapFilterSheet({
    super.key,
    required this.initialSelectedCategories,
    required this.initialIsOperating,
    required this.onApply,
  });

  @override
  State<MapFilterSheet> createState() => _MapFilterSheetState();
}

class _MapFilterSheetState extends State<MapFilterSheet> {
  late Set<String> _selectedCategories;
  PopupStatus? _isOperating;

  static const _categories = [
    '리빙',
    '패션',
    '뷰티',
    '테크',
    '연예',
    '음식',
    '캐릭터',
    '웹툰',
    '애니',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategories = Set.from(widget.initialSelectedCategories);
    _isOperating = widget.initialIsOperating;
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _setOperatingFilter(PopupStatus? value) {
    setState(() {
      _isOperating = value;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCategories.clear();
      _isOperating = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewPadding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '필터',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(LucideIcons.x, color: AppColors.ink, size: 24),
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Categories Title
          const Text(
            '카테고리',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Categories wrap
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children:
                _categories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return GestureDetector(
                    onTap: () => _toggleCategory(category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.ink : Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: isSelected ? AppColors.ink : AppColors.border,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color:
                              isSelected ? AppColors.background : AppColors.ink,
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 28),

          // Operating Status Title
          const Text(
            '운영 여부',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Operating Status Toggle Buttons
          Row(
            children: [
              _buildStatusButton(
                '전체',
                _isOperating == null,
                () => _setOperatingFilter(null),
              ),
              const SizedBox(width: 6),
              _buildStatusButton(
                '오픈예정',
                _isOperating == PopupStatus.openingSoon,
                () => _setOperatingFilter(PopupStatus.openingSoon),
              ),
              const SizedBox(width: 6),
              _buildStatusButton(
                '진행중',
                _isOperating == PopupStatus.inProgress,
                () => _setOperatingFilter(PopupStatus.inProgress),
              ),
              const SizedBox(width: 6),
              _buildStatusButton(
                '종료',
                _isOperating == PopupStatus.ended,
                () => _setOperatingFilter(PopupStatus.ended),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.ink,
                    side: const BorderSide(color: AppColors.border),
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.rotateCcw, size: 16),
                      SizedBox(width: 8),
                      Text('초기화'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_selectedCategories, _isOperating);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('적용하기'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String text, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.ink : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? AppColors.ink : AppColors.border,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? AppColors.background : AppColors.ink,
              fontSize: 12, // Adjusted font size to fit 4 buttons nicely
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
