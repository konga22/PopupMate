import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/extensions/context_extension.dart';
import '../../../app/extensions/spacing_extension.dart';
import '../../common/app_components.dart';
import 'widgets/review_detail_input.dart';
import 'widgets/review_exit_confirmation_dialog.dart';
import 'widgets/review_photo_placeholder.dart';
import 'widgets/review_rating_selector.dart';
import 'widgets/review_submit_button.dart';
import 'widgets/review_target_header.dart';

class ReviewWritePage extends StatefulWidget {
  const ReviewWritePage({super.key});

  @override
  State<ReviewWritePage> createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  final _reviewController = TextEditingController();
  double _rating = 4;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<bool> _confirmExit() async {
    if (_reviewController.text.trim().isEmpty) return true;
    return showReviewExitConfirmationDialog(context);
  }

  void _onSubmit() {
    if (_reviewController.text.trim().isEmpty) {
      context.showSnackbar('상세 리뷰를 입력해주세요.', isError: true);
      return;
    }
    context.showSnackbar('mock 리뷰가 등록되었습니다.');
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _confirmExit();
        if (!context.mounted || !shouldExit) return;
        context.pop();
      },
      child: Scaffold(
        appBar: AppTopBar(
          title: '리뷰 작성',
          showBack: true,
          actions: [TextButton(onPressed: _onSubmit, child: const Text('저장'))],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            const ReviewTargetHeader(),
            26.heightBox,
            ReviewRatingSelector(
              rating: _rating,
              onChanged: (value) => setState(() => _rating = value),
            ),
            const ReviewPhotoPlaceholder(),
            24.heightBox,
            ReviewDetailInput(controller: _reviewController),
            24.heightBox,
            ReviewSubmitButton(onPressed: _onSubmit),
          ],
        ),
      ),
    );
  }
}
