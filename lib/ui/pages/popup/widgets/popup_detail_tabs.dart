import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';

class PopupDetailTabs extends StatelessWidget {
  const PopupDetailTabs({
    super.key,
    required this.selectedTab,
    required this.onSelected,
  });

  final String selectedTab;
  final ValueChanged<String> onSelected;

  static const _tabs = ['정보', '커뮤니티', '리뷰'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children:
            _tabs.map((tab) {
              final selected = tab == selectedTab;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelected(tab),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 18),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selected ? AppColors.ink : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            selected ? AppColors.ink : const Color(0xFF76777B),
                        fontSize: 20,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
