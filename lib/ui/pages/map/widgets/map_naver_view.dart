import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../models/map_mock_data.dart';

class MapNaverView extends StatefulWidget {
  final NLatLng center;
  final double radius;
  final String? selectedCategory;
  final bool? isReservationAvailable;
  final String? searchQuery;
  final ValueChanged<NaverMapController>? onMapReady;
  final ValueChanged<Map<String, dynamic>>? onMarkerTap;

  const MapNaverView({
    super.key,
    required this.center,
    required this.radius,
    this.selectedCategory,
    this.isReservationAvailable,
    this.searchQuery,
    this.onMapReady,
    this.onMarkerTap,
  });

  @override
  State<MapNaverView> createState() => _MapNaverViewState();
}

class _MapNaverViewState extends State<MapNaverView> {
  NaverMapController? _mapController;
  final Map<String, NOverlayImage> _markerCache = {};

  @override
  void didUpdateWidget(covariant MapNaverView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_mapController != null) {
      if (oldWidget.center != widget.center || 
          oldWidget.radius != widget.radius ||
          oldWidget.selectedCategory != widget.selectedCategory ||
          oldWidget.isReservationAvailable != widget.isReservationAvailable ||
          oldWidget.searchQuery != widget.searchQuery) {
        _updateOverlays();
        _moveCameraToCenter();
      }
    }
  }

  void _onMapReady(NaverMapController controller) {
    _mapController = controller;
    _updateOverlays();
    if (widget.onMapReady != null) {
      widget.onMapReady!(controller);
    }
  }

  void _moveCameraToCenter() {
    if (_mapController == null) return;
    _mapController!.updateCamera(
      NCameraUpdate.withParams(
        target: widget.center,
        zoom: _getZoomLevelForRadius(widget.radius),
      ),
    );
  }

  double _getZoomLevelForRadius(double radius) {
    if (radius <= 100) return 16.5;
    if (radius <= 500) return 15.0;
    return 14.0;
  }

  Future<void> _updateOverlays() async {
    if (_mapController == null) return;

    // 1. Filter popups
    final filteredPopups = MapMockData.popups.where((popup) {
      if (widget.selectedCategory != null && popup['cat'] != widget.selectedCategory) return false;
      if (widget.isReservationAvailable != null && popup['res'] != widget.isReservationAvailable) return false;
      if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
        final title = (popup['title'] as String).toLowerCase();
        final query = widget.searchQuery!.toLowerCase();
        if (!title.contains(query)) return false;
      }
      
      final pos = popup['pos'] as NLatLng;
      final distance = Geolocator.distanceBetween(
        widget.center.latitude,
        widget.center.longitude,
        pos.latitude,
        pos.longitude,
      );
      if (distance > widget.radius) return false;
      
      return true;
    }).toList();

    // 2. Draw what we currently have
    _drawOverlays(filteredPopups);

    // 3. Generate missing custom icons asynchronously
    bool needsRedraw = false;
    for (var popup in filteredPopups) {
      final id = popup['id'] as String;
      if (!_markerCache.containsKey(id)) {
        try {
          if (!mounted) return;
          
          _markerCache[id] = await NOverlayImage.fromWidget(
            widget: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFF25042),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.storefront,
                color: Colors.white,
                size: 16,
              ),
            ),
            size: const Size(28, 28),
            context: context,
          );
          needsRedraw = true;
        } catch (e) {
          debugPrint('Error generating custom marker: $e');
        }
      }
    }

    // 4. Redraw if new icons were generated
    if (needsRedraw && mounted) {
      _drawOverlays(filteredPopups);
    }
  }

  void _drawOverlays(List<Map<String, dynamic>> popups) {
    if (_mapController == null) return;
    _mapController!.clearOverlays();

    final circle = NCircleOverlay(
      id: 'search_radius_circle',
      center: widget.center,
      radius: widget.radius,
      color: AppColors.ink.withValues(alpha: 0.05),
      outlineColor: AppColors.ink.withValues(alpha: 0.2),
      outlineWidth: 2,
    );
    _mapController!.addOverlay(circle);

    for (var popup in popups) {
      final id = popup['id'] as String;
      final marker = NMarker(
        id: id,
        position: popup['pos'] as NLatLng,
        caption: NOverlayCaption(text: popup['title'] as String),
        icon: _markerCache[id], // Use custom icon if available
      );
      
      marker.setOnTapListener((overlay) {
        if (widget.onMarkerTap != null) {
          widget.onMarkerTap!(popup);
        }
      });
      
      _mapController!.addOverlay(marker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: widget.center,
          zoom: _getZoomLevelForRadius(widget.radius),
        ),
        mapType: NMapType.basic,
        activeLayerGroups: const [
          NLayerGroup.building,
          NLayerGroup.transit,
        ],
      ),
      onMapReady: _onMapReady,
    );
  }
}
