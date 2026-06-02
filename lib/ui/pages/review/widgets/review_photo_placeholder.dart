import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../common/app_components.dart';

class ReviewPhotoPlaceholder extends StatelessWidget {
  const ReviewPhotoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyPlaceholder(
      title: '사진 추가 (최대 5장)',
      message: '0/5 · 실제 업로드는 다음 Firebase 단계에서 연결합니다.',
      icon: LucideIcons.image,
    );
  }
}
