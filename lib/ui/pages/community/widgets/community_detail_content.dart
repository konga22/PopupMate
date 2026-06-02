import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/community_models.dart';
import '../../../common/app_components.dart';
import 'comment_input.dart';
import 'community_comments_section.dart';
import 'community_post_action_row.dart';

class CommunityDetailContent extends StatelessWidget {
  const CommunityDetailContent({
    super.key,
    required this.post,
    required this.onAddComment,
    required this.commentController,
  });

  final CommunityPost post;
  final VoidCallback onAddComment;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  StatusBadge(label: post.category),
                  10.widthBox,
                  Text(
                    post.timeAgo,
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
              16.heightBox,
              Text(
                post.title,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              8.heightBox,
              Text(
                post.popupTitle,
                style: const TextStyle(color: AppColors.muted),
              ),
              24.heightBox,
              Text(
                post.body,
                style: const TextStyle(
                  color: AppColors.body,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              32.heightBox,
              const Divider(color: AppColors.softBorder),
              CommunityPostActionRow(post: post),
              24.heightBox,
              CommunityCommentsSection(postId: post.id),
            ],
          ),
        ),
        CommentInput(controller: commentController, onSend: onAddComment),
      ],
    );
  }
}
