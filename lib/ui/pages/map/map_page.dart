import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../services/location_service.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
import 'widgets/map_header.dart';
import 'widgets/map_viewport.dart';

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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(activeTab: AppTab.map),
    );
  }
}
