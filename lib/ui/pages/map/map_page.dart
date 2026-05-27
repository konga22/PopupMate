import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../services/location_service.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
import 'widgets/map_search_bar.dart';
import 'widgets/map_floating_controls.dart';
import 'widgets/map_quick_preview_card.dart';
import 'widgets/map_naver_view.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _radiusOptions = [100, 500, 1000];

  int _radius = 500;
  bool _saved = false;
  NLatLng _currentCenter = const NLatLng(37.5445, 127.0560); // 성수동 중심 좌표

  String get _radiusLabel => _radius == 1000 ? '1km' : '${_radius}m';

  void _selectRadius(int value) {
    setState(() {
      _radius = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _MapHeader(),
            Expanded(
              child: Stack(
                children: [
                  // 1. 네이버 지도 뷰
                  Positioned.fill(
                    child: MapNaverView(
                      center: _currentCenter,
                      radius: _radius.toDouble(),
                    ),
                  ),

                  // 2. 지도 위의 상단 검색창 및 컨트롤들
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 16,
                    child: Column(
                      children: [
                        MapSearchBar(
                          onSearch: (query) {
                            debugPrint('Search query: $query');
                          },
                        ),
                        const SizedBox(height: 16),
                        MapFloatingControls(
                          radiusLabel: _radiusLabel,
                          radiusOptions: _radiusOptions,
                          selectedRadius: _radius,
                          onRadiusSelected: _selectRadius,
                          onCurrentLocationTap: () async {
                            try {
                              context.showSnackbar('위치 정보를 가져오는 중...');
                              final position =
                                  await LocationService.getCurrentPosition();

                              if (!context.mounted) return;
                              setState(() {
                                _currentCenter = NLatLng(
                                  position.latitude,
                                  position.longitude,
                                );
                                _radius = 500;
                              });
                              context.showSnackbar(
                                '현재 위치: 위도 ${position.latitude.toStringAsFixed(4)}, 경도 ${position.longitude.toStringAsFixed(4)}',
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              context.showSnackbar(
                                e.toString().replaceAll('Exception: ', ''),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  // 3. 지도 위의 하단 프리뷰 카드
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 32,
                    child: MapQuickPreviewCard(
                      saved: _saved,
                      onWaitingTap:
                          () => context.pushNamed(AppPage.waiting.name),
                      onSaveTap: () => setState(() => _saved = !_saved),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.map),
    );
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          _IconTapTarget(
            icon: LucideIcons.arrowLeft,
            iconSize: 22,
            onTap: () {
              if (context.canPop()) {
                context.pop();
                return;
              }

              context.goNamed(AppPage.home.name);
            },
          ),
          const Expanded(
            child: Text(
              '주변 팝업',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 20,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          _IconTapTarget(icon: LucideIcons.share2, iconSize: 21, onTap: () {}),
        ],
      ),
    );
  }
}

class _IconTapTarget extends StatelessWidget {
  const _IconTapTarget({
    required this.icon,
    required this.onTap,
    this.iconSize = 20,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Icon(icon, color: AppColors.ink, size: iconSize),
      ),
    );
  }
}
