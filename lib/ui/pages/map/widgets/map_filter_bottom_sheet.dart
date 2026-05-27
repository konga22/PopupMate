import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class MapFilterResult {
  final String? category;
  final bool? isReservationAvailable;

  const MapFilterResult({this.category, this.isReservationAvailable});
}

class MapFilterBottomSheet extends StatefulWidget {
  final String? initialCategory;
  final bool? initialReservationAvailable;

  const MapFilterBottomSheet({
    super.key,
    this.initialCategory,
    this.initialReservationAvailable,
  });

  @override
  State<MapFilterBottomSheet> createState() => _MapFilterBottomSheetState();
}

class _MapFilterBottomSheetState extends State<MapFilterBottomSheet> {
  static const _categories = [
    '리빙', '패션', '뷰티', '테크', '연예', '음식', '캐릭터', '웹툰', '애니', '취미'
  ];

  String? _selectedCategory;
  bool? _isReservationAvailable;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _isReservationAvailable = widget.initialReservationAvailable;
  }

  void _applyFilter() {
    Navigator.of(context).pop(
      MapFilterResult(
        category: _selectedCategory,
        isReservationAvailable: _isReservationAvailable,
      ),
    );
  }

  void _resetFilter() {
    setState(() {
      _selectedCategory = null;
      _isReservationAvailable = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '필터',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              GestureDetector(
                onTap: _resetFilter,
                child: const Text(
                  '초기화',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // 카테고리 섹션
          const Text(
            '카테고리',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedCategory = null;
                    } else {
                      _selectedCategory = category;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.ink : Colors.white,
                    border: Border.all(
                      color: isSelected ? AppColors.ink : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : AppColors.ink,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          // 예약 가능 여부 섹션
          const Text(
            '네이버 예약',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ReservationButton(
                  title: '예약가능',
                  isSelected: _isReservationAvailable == true,
                  onTap: () {
                    setState(() {
                      if (_isReservationAvailable == true) {
                        _isReservationAvailable = null;
                      } else {
                        _isReservationAvailable = true;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ReservationButton(
                  title: '예약불가능',
                  isSelected: _isReservationAvailable == false,
                  onTap: () {
                    setState(() {
                      if (_isReservationAvailable == false) {
                        _isReservationAvailable = null;
                      } else {
                        _isReservationAvailable = false;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // 적용 버튼
          GestureDetector(
            onTap: _applyFilter,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text(
                '적용하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReservationButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReservationButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.ink : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.ink : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: isSelected ? Colors.white : AppColors.ink,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
