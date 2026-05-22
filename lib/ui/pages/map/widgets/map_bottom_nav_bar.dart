import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_tab.dart';
import '../../../../app/theme/app_theme.dart';

class MapBottomNavBar extends StatelessWidget {
  final AppTab activeTab;

  const MapBottomNavBar({super.key, required this.activeTab});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      height: 100 + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: AppTab.values.map((tab) {
          return Expanded(
            child: _MapBottomNavItem(
              tab: tab,
              active: tab == activeTab,
              onTap: () {
                if (tab == activeTab) {
                  return;
                }
                context.goNamed(tab.page.name);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MapBottomNavItem extends StatelessWidget {
  const _MapBottomNavItem({
    required this.tab,
    required this.active,
    required this.onTap,
  });

  final AppTab tab;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          padding: active
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
              : const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: active ? AppColors.ink : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: active
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tab.icon,
                color: active ? Colors.white : const Color(0xFF45474B),
                size: 20,
              ),
              SizedBox(height: active ? 2 : 4),
              Text(
                tab.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF45474B),
                  fontSize: 12,
                  height: 1.33,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
