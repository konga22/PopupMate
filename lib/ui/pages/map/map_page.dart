import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../models/popup_models.dart';
import '../../../services/location_service.dart';
import '../../../services/popup/mock_popup_service.dart';
import '../../common/navigation/app_bottom_nav_bar.dart';
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
    final categories = ['패션', '뷰티', '리빙', '음식', '테크', '연예', '캐릭터', '웹툰', '애니'];
    for (final category in categories) {
      try {
        final iconData = _markerIconForCategory(category);
        final pinColor = _colorForCategory(category);
        
        // Draw and write the premium pin file using Canvas and TextPainter
        final file = await _createPremiumPinFile(category, iconData, pinColor);
        final overlayImage = NOverlayImage.fromFile(file);
        
        if (mounted) {
          setState(() {
            _categoryMarkerIcons[category] = overlayImage;
          });
        }
      } catch (e) {
        debugPrint('Error drawing custom marker for $category: $e');
      }
    }
  }

  static IconData _markerIconForCategory(String category) {
    return LucideIcons.store; // 실제 네이버 지도처럼 모든 팝업스토어에 상점/쇼핑백 아이콘 적용
  }

  static Color _colorForCategory(String category) {
    return const Color(0xFFF24822); // 실제 네이버 지도 팝업스토어 전용 레드-오렌지 색상 적용
  }

  Future<File> _createPremiumPinFile(String category, IconData iconData, Color pinColor) async {
    const double width = 120.0;
    const double height = 120.0;
    
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, width, height));
    
    // Naver Map Style Pin Path (Circle center 60, 52, radius 32, bottom tip 60, 90)
    final path = Path();
    path.moveTo(36, 70);
    path.arcToPoint(
      const Offset(84, 70),
      radius: const Radius.circular(32),
      clockwise: true,
      largeArc: true,
    );
    path.lineTo(60, 90);
    path.lineTo(36, 70);
    path.close();
    
    // 1. 입체감을 주는 드롭 섀도우 (Drop Shadow)
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path.shift(const Offset(0, 3.5)), shadowPaint);
    
    // 2. 단색 채우기 (Solid color fill)
    final fillPaint = Paint()
      ..color = pinColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
    
    // 3. 선명한 흰색 외곽 테두리 (Stroke)
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, borderPaint);
    
    // 4. Lucide 아이콘 그리기 (TextPainter) - 흰색으로 중심 배치
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: 28.0,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: Colors.white, // 흰색 아이콘
      ),
    );
    textPainter.layout();
    
    final offset = Offset(
      60.0 - textPainter.width / 2,
      52.0 - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
    
    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/premium_pin_${category}_$_sessionKey.png');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  String get _radiusLabel => '${_radius}m';

  List<Popup> get _filteredPopups {
    return MockPopupService.popups.where((popup) {
      // 1. Category Filter
      if (_selectedCategories.isNotEmpty &&
          !_selectedCategories.contains(popup.category)) {
        return false;
      }
      // 2. Operating Status Filter
      if (_isOperatingFilter != null &&
          popup.status != _isOperatingFilter) {
        return false;
      }
      // 3. Distance/Radius Filter
      if (popup.latitude != null && popup.longitude != null) {
        final distance = Geolocator.distanceBetween(
          _currentCenter.latitude,
          _currentCenter.longitude,
          popup.latitude!,
          popup.longitude!,
        );
        if (distance > _radius) {
          return false;
        }
      }
      return true;
    }).toList();
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
