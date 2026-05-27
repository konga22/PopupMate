import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/community_models.dart';
import '../../../../services/community/community_service.dart';
import '../../../common/app_components.dart';
import 'comment_input.dart';
import 'comment_tile.dart';

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
    final isLiked = CommunityService.isLikedByCurrentUser(post);

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
              Row(
                children: [
                  IconButton(
                    onPressed: () => CommunityService.toggleLike(post.id),
                    icon: Icon(
                      LucideIcons.heart,
                      color: isLiked ? AppColors.danger : AppColors.muted,
                    ),
                  ),
                  Text('${post.likes}명이 좋아합니다'),
                  const Spacer(),
                  const Icon(
                    LucideIcons.messageCircle,
                    size: 20,
                    color: AppColors.muted,
                  ),
                  5.widthBox,
                  Text('댓글 ${post.comments}'),
                ],
              ),
              24.heightBox,
              const SectionHeader(title: '댓글', caption: 'Comments'),
              16.heightBox,
              StreamBuilder<List<CommunityComment>>(
                stream: CommunityService.getComments(post.id),
                builder: (context, snapshot) {
                  final comments = snapshot.data ?? const <CommunityComment>[];
                  if (comments.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text('첫 댓글을 남겨보세요!')),
                    );
                  }

                  return Column(
                    children:
                        comments
                            .map((comment) => CommentTile(comment: comment))
                            .toList(),
                  );
                },
              ),
            ],
          ),
        ),
        CommentInput(controller: commentController, onSend: onAddComment),
      ],
    );
  }
}
