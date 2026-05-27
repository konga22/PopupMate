import 'package:flutter/material.dart';

void showNotReadySnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('아직 mock UI 단계입니다. 다음 단계에서 실제 기능을 연결합니다.'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
