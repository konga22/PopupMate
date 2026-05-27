import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../services/location_service.dart';
import 'widgets/map_search_bar.dart';
import 'widgets/map_bottom_nav_bar.dart';
import 'widgets/map_floating_controls.dart';
import 'widgets/map_quick_preview_card.dart';
import 'widgets/map_naver_view.dart';
import 'widgets/map_filter_bottom_sheet.dart';
import '../../../models/map_mock_data.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _radiusOptions = [100, 250, 500];

  int _radius = 500;
  bool _saved = false;
  NLatLng _currentCenter = const NLatLng(37.5445, 127.0560); // 성수동 중심 좌표

  String? _selectedCategory;
  bool? _isReservationAvailable;
  Map<String, dynamic>? _selectedPopup;

  final _searchController = TextEditingController();
  String _currentInput = '';
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _selectedPopup = MapMockData.popups.isNotEmpty ? MapMockData.popups.first : null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _suggestions {
    if (_currentInput.isEmpty) return [];
    return MapMockData.popups
        .where((p) => (p['title'] as String).toLowerCase().contains(_currentInput.toLowerCase()))
        .toList();
  }

  void _submitSearch(String query) {
    setState(() {
      _searchQuery = query;
      _currentInput = '';
      _searchController.text = query;
    });
    FocusScope.of(context).unfocus();
  }

  String _getDistanceLabel(NLatLng pos) {
    final distance = Geolocator.distanceBetween(
      _currentCenter.latitude,
      _currentCenter.longitude,
      pos.latitude,
      pos.longitude,
    );
    if (distance < 1000) {
      return '${distance.round()}m away';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)}km away';
    }
  }

  String get _radiusLabel => '${_radius}m';

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
                      selectedCategory: _selectedCategory,
                      isReservationAvailable: _isReservationAvailable,
                      searchQuery: _searchQuery,
                      onMarkerTap: (popup) {
                        setState(() {
                          _selectedPopup = popup;
                        });
                      },
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
                          controller: _searchController,
                          onChanged: (val) {
                            setState(() {
                              _currentInput = val;
                              if (val.isEmpty) _searchQuery = null; // Clear filter if search is empty
                            });
                          },
                          onSearch: _submitSearch,
                          onFilterTap: () async {
                            final result = await showModalBottomSheet<MapFilterResult>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => MapFilterBottomSheet(
                                initialCategory: _selectedCategory,
                                initialReservationAvailable: _isReservationAvailable,
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                _selectedCategory = result.category;
                                _isReservationAvailable = result.isReservationAvailable;
                              });
                            }
                          },
                        ),
                        if (_currentInput.isNotEmpty && _suggestions.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: _suggestions.map((p) {
                                return ListTile(
                                  leading: const Icon(LucideIcons.search, size: 16, color: AppColors.body),
                                  title: Text(
                                    p['title'] as String,
                                    style: const TextStyle(fontSize: 14, color: AppColors.ink),
                                  ),
                                  dense: true,
                                  onTap: () => _submitSearch(p['title'] as String),
                                );
                              }).toList(),
                            ),
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
                              final position = await LocationService.getCurrentPosition();

                              if (!context.mounted) return;
                              setState(() {
                                _currentCenter = NLatLng(position.latitude, position.longitude);
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
                  if (_selectedPopup != null)
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 32,
                      child: MapQuickPreviewCard(
                        popup: _selectedPopup!,
                        distanceLabel: _getDistanceLabel(_selectedPopup!['pos'] as NLatLng),
                        saved: _saved,
                        onWaitingTap: () => context.pushNamed(AppPage.waiting.name),
                        onSaveTap: () => setState(() => _saved = !_saved),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MapBottomNavBar(activeTab: AppTab.map),
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
