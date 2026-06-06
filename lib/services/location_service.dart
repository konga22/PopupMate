import 'package:geolocator/geolocator.dart';

class LocationService {
  /// 현재 위치 권한을 확인하고 GPS 좌표를 가져옵니다.
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 기기의 위치 서비스가 켜져 있는지 확인합니다.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('기기의 위치 서비스가 꺼져 있습니다. 설정에서 켜주세요.');
    }

    // 현재 앱의 위치 권한 상태를 확인합니다.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 권한이 없다면 사용자에게 권한을 요청합니다.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 권한이 영구적으로 거부된 상태라면 예외를 발생시킵니다.
      throw Exception('위치 권한이 영구적으로 거부되었습니다. 앱 설정에서 권한을 허용해주세요.');
    }

    // 모든 권한이 확인되면 현재 위치를 가져와 반환합니다.
    return await Geolocator.getCurrentPosition();
  }

  /// 두 GPS 좌표 간의 거리를 계산하여 미터(m) 단위로 반환합니다.
  static double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
