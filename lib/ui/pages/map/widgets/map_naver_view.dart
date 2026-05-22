import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../../app/theme/app_theme.dart';

class MapNaverView extends StatefulWidget {
  final NLatLng center;
  final double radius;
  final ValueChanged<NaverMapController>? onMapReady;

  const MapNaverView({
    super.key,
    required this.center,
    required this.radius,
    this.onMapReady,
  });

  @override
  State<MapNaverView> createState() => _MapNaverViewState();
}

class _MapNaverViewState extends State<MapNaverView> {
  NaverMapController? _mapController;

  @override
  void didUpdateWidget(covariant MapNaverView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_mapController != null) {
      if (oldWidget.center != widget.center || oldWidget.radius != widget.radius) {
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

  void _updateOverlays() {
    if (_mapController == null) return;

    _mapController!.clearOverlays();

    // 1. Add Circle Overlay for search radius
    final circle = NCircleOverlay(
      id: 'search_radius_circle',
      center: widget.center,
      radius: widget.radius,
      color: AppColors.ink.withValues(alpha: 0.05),
      outlineColor: AppColors.ink.withValues(alpha: 0.2),
      outlineWidth: 2,
    );
    _mapController!.addOverlay(circle);

    // 2. Add Seongsu area mock markers (Pins & Clusters)
    // Pin Marker (representing a specific popup, e.g., Aromatic Cloud Popup)
    final pinMarker = NMarker(
      id: 'pin_marker_aromatic',
      position: const NLatLng(37.5460, 127.0535),
      caption: const NOverlayCaption(text: 'Aromatic Cloud Popup'),
    );
    _mapController!.addOverlay(pinMarker);

    // Cluster Marker 1 (e.g. 12 popups at Seongsu station area)
    if (widget.radius >= 500) {
      final cluster1 = NMarker(
        id: 'cluster_marker_1',
        position: const NLatLng(37.5445, 127.0560),
        caption: const NOverlayCaption(text: '12개 팝업'),
      );
      _mapController!.addOverlay(cluster1);
    }

    // Cluster Marker 2 (e.g. 5 popups further away)
    if (widget.radius >= 1000) {
      final cluster2 = NMarker(
        id: 'cluster_marker_2',
        position: const NLatLng(37.5420, 127.0600),
        caption: const NOverlayCaption(text: '5개 팝업'),
      );
      _mapController!.addOverlay(cluster2);
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
