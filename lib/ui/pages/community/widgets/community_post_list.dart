import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../models/community_models.dart';
import '../../../../services/community_service.dart';
import '../../../../services/mock_community_service.dart';
import '../../../common/app_components.dart';
import 'community_post_card.dart';

class CommunityPostList extends StatelessWidget {
  const CommunityPostList({
    super.key,
    required this.category,
    required this.onCategorySelected,
  });

  final String category;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CommunityPost>>(
      stream: CommunityService.getPosts(category: category),
      builder: (context, snapshot) {
        final posts = _postsFor(snapshot);

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            FilterChipBar(
              labels: const ['전체', '메이트', '후기', '교환', '질문'],
              selected: category,
              onSelected: onCategorySelected,
            ),
            24.heightBox,
            const SectionHeader(title: '인기 게시글', caption: 'Mate Board'),
            16.heightBox,
            if (snapshot.hasError) const _MockFallbackNotice(),
            ...posts.map(
              (post) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: CommunityPostCard(post: post),
              ),
            ),
          ],
        );
      },
    );
  }

  List<CommunityPost> _postsFor(AsyncSnapshot<List<CommunityPost>> snapshot) {
    final firestorePosts = snapshot.data ?? const <CommunityPost>[];
    if (firestorePosts.isNotEmpty) return firestorePosts;

    final mockPosts = MockCommunityService.posts;
    if (category == '전체') return mockPosts;
    return mockPosts.where((post) => post.category == category).toList();
  }
}

class _MockFallbackNotice extends StatelessWidget {
  const _MockFallbackNotice();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Text(
        'Firestore 연결 전까지 mock 게시글을 표시합니다.',
        style: TextStyle(color: AppColors.muted),
      ),
    );
  }
}
