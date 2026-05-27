import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PermissionItem {
  const PermissionItem({
    required this.icon,
    required this.title,
    required this.badge,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String badge;
  final String message;
}

const permissionItems = [
  PermissionItem(
    icon: LucideIcons.mapPin,
    title: '위치',
    badge: '필수',
    message: '주변 팝업 추천 및 웨이팅 현황 파악을 위해 현재 위치 정보가 필요합니다.',
  ),
  PermissionItem(
    icon: LucideIcons.bell,
    title: '알림',
    badge: '선택',
    message: '입장 순서 안내, 예약 확정 및 혜택 정보를 실시간으로 보내드립니다.',
  ),
  PermissionItem(
    icon: LucideIcons.camera,
    title: '카메라 및 사진',
    badge: '선택',
    message: '프로필 이미지 설정 및 리뷰 작성 시 사진 첨부를 위해 사용됩니다.',
  ),
];
