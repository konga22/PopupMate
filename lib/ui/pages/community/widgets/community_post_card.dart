import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/router/app_page.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/community_models.dart';
import '../../../common/app_components.dart';

class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({super.key, required this.post});

  final CommunityPost post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        context.pushNamed(
          AppPage.communityDetail.name,
          pathParameters: {'postId': post.id},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.softBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.surfaceAlt,
                  child: Text(post.author.isEmpty ? '?' : post.author[0]),
                ),
                10.widthBox,
                Expanded(
                  child: Text(
                    '${post.author} · ${post.timeAgo}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                StatusBadge(label: post.status),
              ],
            ),
            14.heightBox,
            Text(
              post.title,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            6.heightBox,
            Text(
              post.popupTitle,
              style: const TextStyle(color: AppColors.muted),
            ),
            10.heightBox,
            Text(
              post.body,
              style: const TextStyle(color: AppColors.body, height: 1.45),
            ),
            14.heightBox,
            Row(
              children: [
                const Icon(LucideIcons.heart, size: 16, color: AppColors.muted),
                5.widthBox,
                Text('${post.likes}'),
                14.widthBox,
                const Icon(
                  LucideIcons.messageCircle,
                  size: 16,
                  color: AppColors.muted,
                ),
                5.widthBox,
                Text('${post.comments}'),
                const Spacer(),
                const Text('자세히 보기'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
