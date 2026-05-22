import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.activeTab});

  final AppTab activeTab;

  static const _contentHeight = 62.0;
  static const _horizontalPadding = 16.0;
  static const _iconBoxWidth = 38.0;
  static const _iconBoxHeight = 30.0;
  static const _iconSize = 25.0;
  static const _labelSize = 12.0;
  static const _iconLabelGap = 6.0;
  static const _maxBottomInset = 28.0;

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.viewPaddingOf(
          context,
        ).bottom.clamp(0.0, _maxBottomInset).toDouble();

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: _contentHeight + bottomInset,
          child: Column(
            children: [
              SizedBox(
                height: _contentHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding,
                  ),
                  child: Row(
                    children:
                        AppTab.values.map((tab) {
                          final isActive = tab == activeTab;

                          return Expanded(
                            child: InkWell(
                              onTap:
                                  isActive
                                      ? null
                                      : () => context.goNamed(tab.page.name),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: _iconBoxWidth,
                                    height: _iconBoxHeight,
                                    decoration: BoxDecoration(
                                      color:
                                          isActive
                                              ? AppColors.ink.withValues(
                                                alpha: 0.1,
                                              )
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      tab.icon,
                                      size: _iconSize,
                                      color:
                                          isActive
                                              ? AppColors.ink
                                              : AppColors.muted,
                                    ),
                                  ),
                                  const SizedBox(height: _iconLabelGap),
                                  Text(
                                    tab.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color:
                                          isActive
                                              ? AppColors.ink
                                              : AppColors.muted,
                                      fontSize: _labelSize,
                                      fontWeight:
                                          isActive
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                      height: 1.33,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
              if (bottomInset > 0)
                SizedBox(
                  height: bottomInset,
                  child: const ColoredBox(
                    color: AppColors.surfaceAlt,
                    child: SizedBox.expand(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
