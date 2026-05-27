import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../../../../app/theme/app_theme.dart';
import 'map_camera_zoom.dart';
import 'map_overlay_factory.dart';

const _naverMapClientId = String.fromEnvironment('NAVER_MAP_CLIENT_ID');

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
      if (oldWidget.center != widget.center ||
          oldWidget.radius != widget.radius) {
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
        zoom: mapZoomLevelForRadius(widget.radius),
      ),
    );
  }

  void _updateOverlays() {
    if (_mapController == null) return;

    _mapController!.clearOverlays();
    for (final overlay in MapOverlayFactory.overlays(
      center: widget.center,
      radius: widget.radius,
    )) {
      _mapController!.addOverlay(overlay);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_naverMapClientId.isEmpty) {
      return const ColoredBox(
        color: AppColors.surfaceAlt,
        child: Center(
          child: Text(
            '네이버 지도 키가 설정되지 않았습니다.',
            style: TextStyle(color: AppColors.body),
          ),
        ),
      );
    }

    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: widget.center,
          zoom: mapZoomLevelForRadius(widget.radius),
        ),
        mapType: NMapType.basic,
        activeLayerGroups: const [NLayerGroup.building, NLayerGroup.transit],
      ),
      onMapReady: _onMapReady,
    );
  }
}
