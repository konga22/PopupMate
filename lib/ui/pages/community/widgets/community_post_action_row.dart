import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/community_models.dart';
import '../../../../services/community_service.dart';

class CommunityPostActionRow extends StatelessWidget {
  const CommunityPostActionRow({super.key, required this.post});

  final CommunityPost post;

  @override
  Widget build(BuildContext context) {
    final isLiked = CommunityService.isLikedByCurrentUser(post);

    return Row(
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
        const Icon(LucideIcons.messageCircle, size: 20, color: AppColors.muted),
        5.widthBox,
        Text('댓글 ${post.comments}'),
      ],
    );
  }
}
