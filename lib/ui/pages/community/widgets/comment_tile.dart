import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/community_models.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment});

  final CommunityComment comment;

  @override
  Widget build(BuildContext context) {
    final initial = comment.author.isEmpty ? '?' : comment.author[0];

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceAlt,
            child: Text(initial, style: const TextStyle(fontSize: 12)),
          ),
          12.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.author,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                4.heightBox,
                Text(
                  comment.body,
                  style: const TextStyle(color: AppColors.body),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
