import 'package:flutter/material.dart';

Future<bool> showReviewExitConfirmationDialog(BuildContext context) async {
  final shouldExit = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('작성을 중단하시겠어요?'),
          content: const Text('지금 나가시면 작성 중인 내용이 저장되지 않습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('계속 작성하기'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('나가기'),
            ),
          ],
        ),
  );

  return shouldExit ?? false;
}
