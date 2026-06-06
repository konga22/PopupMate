import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../models/popup_models.dart';
import '../../../services/location_service.dart';
import '../../../services/popup/mock_popup_service.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
import 'helpers/map_marker_helper.dart';
import 'widgets/map_filter_sheet.dart';
import 'widgets/map_header.dart';
import 'widgets/map_viewport.dart';

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

  final Set<String> _selectedCategories = {};
  PopupStatus? _isOperatingFilter;
  Popup? _selectedPopup;

  final Map<String, NOverlayImage> _categoryMarkerIcons = {};
  final String _sessionKey = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    _selectedPopup = MockPopupService.popups.firstWhere(
      (p) => p.id == 'aromatic-cloud',
      orElse: () => MockPopupService.popups.first,
    );
    _loadMarkerIcons();
  }

  Future<void> _loadMarkerIcons() async {
    try {
      final icons = await MapMarkerHelper.loadMarkerIcons(_sessionKey);
      if (mounted) {
        setState(() {
          _categoryMarkerIcons.addAll(icons);
        });
      }
    } catch (e) {
      debugPrint('Error loading marker icons: $e');
    }
  }

  String get _radiusLabel => '${_radius}m';

  List<Popup> get _filteredPopups {
    return MockPopupService.getFilteredPopups(
      selectedCategories: _selectedCategories,
      isOperatingFilter: _isOperatingFilter,
      currentLatitude: _currentCenter.latitude,
      currentLongitude: _currentCenter.longitude,
      radius: _radius,
    );
  }

  void _selectRadius(int value) {
    setState(() {
      _radius = value;

      // Update selected popup based on the new filtered list
      final filtered = _filteredPopups;
      if (filtered.isEmpty) {
        _selectedPopup = null;
      } else if (_selectedPopup == null || !filtered.contains(_selectedPopup)) {
        _selectedPopup = filtered.first;
      }
    });
  }

  void _onSearch(String query) {
    debugPrint('Search query: $query');
  }

  Future<void> _moveToCurrentLocation() async {
    try {
      context.showSnackbar('위치 정보를 가져오는 중...');
      final position = await LocationService.getCurrentPosition();

      if (!mounted) return;
      setState(() {
        _currentCenter = NLatLng(position.latitude, position.longitude);
        _radius = 500;
      });
      context.showSnackbar(
        '현재 위치: 위도 ${position.latitude.toStringAsFixed(4)}, 경도 ${position.longitude.toStringAsFixed(4)}',
      );
    } catch (error) {
      if (!mounted) return;
      context.showSnackbar(error.toString().replaceAll('Exception: ', ''));
    }
  }

  void _toggleSaved() {
    setState(() => _saved = !_saved);
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return MapFilterSheet(
          initialSelectedCategories: _selectedCategories,
          initialIsOperating: _isOperatingFilter,
          onApply: (categories, isOperating) {
            setState(() {
              _selectedCategories.clear();
              _selectedCategories.addAll(categories);
              _isOperatingFilter = isOperating;

              // Update selected popup based on the new filtered list
              final filtered = _filteredPopups;
              if (filtered.isEmpty) {
                _selectedPopup = null;
              } else if (_selectedPopup == null ||
                  !filtered.contains(_selectedPopup)) {
                _selectedPopup = filtered.first;
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const MapHeader(),
            Expanded(
              child: MapViewport(
                center: _currentCenter,
                radius: _radius,
                radiusLabel: _radiusLabel,
                radiusOptions: _radiusOptions,
                saved: _saved,
                onSearch: _onSearch,
                onRadiusSelected: _selectRadius,
                onCurrentLocationTap: _moveToCurrentLocation,
                onWaitingTap: () => context.pushNamed(AppPage.waiting.name),
                onSaveTap: _toggleSaved,
                filteredPopups: _filteredPopups,
                selectedPopup: _selectedPopup,
                onPopupSelected: (popup) {
                  setState(() {
                    _selectedPopup = popup;
                  });
                },
                onFilterTap: _showFilterSheet,
                categoryMarkerIcons: _categoryMarkerIcons,
                onCenterChanged: (newCenter) {
                  setState(() {
                    _currentCenter = newCenter;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.map),
    );
  }
}
