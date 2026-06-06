import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MapMarkerHelper {
  const MapMarkerHelper._();

  static IconData markerIconForCategory(String category) {
    return LucideIcons.store; // 실제 네이버 지도처럼 모든 팝업스토어에 상점/쇼핑백 아이콘 적용
  }

  static Color colorForCategory(String category) {
    return const Color(0xFFF24822); // 실제 네이버 지도 팝업스토어 전용 - 레드-오렌지 색상 적용
  }

  static Future<File> createPremiumPinFile(
    String category,
    IconData iconData,
    Color pinColor,
    String sessionKey,
  ) async {
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
    final shadowPaint =
        Paint()
          ..color = Colors.black.withValues(alpha: 0.25)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path.shift(const Offset(0, 3.5)), shadowPaint);

    // 2. 단색 채우기 (Solid color fill)
    final fillPaint =
        Paint()
          ..color = pinColor
          ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. 선명한 흰색 외곽 테두리 (Stroke)
    final borderPaint =
        Paint()
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
    final file = File(
      '${tempDir.path}/premium_pin_${category}_$sessionKey.png',
    );
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<Map<String, NOverlayImage>> loadMarkerIcons(
    String sessionKey,
  ) async {
    final Map<String, NOverlayImage> categoryMarkerIcons = {};
    final categories = ['패션', '뷰티', '리빙', '음식', '테크', '연예', '캐릭터', '웹툰', '애니'];
    for (final category in categories) {
      try {
        final iconData = markerIconForCategory(category);
        final pinColor = colorForCategory(category);

        final file = await createPremiumPinFile(
          category,
          iconData,
          pinColor,
          sessionKey,
        );
        final overlayImage = NOverlayImage.fromFile(file);
        categoryMarkerIcons[category] = overlayImage;
      } catch (e) {
        debugPrint('Error drawing custom marker for $category: $e');
      }
    }
    return categoryMarkerIcons;
  }
}
