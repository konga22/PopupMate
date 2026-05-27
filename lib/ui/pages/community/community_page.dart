import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../models/community_models.dart';
import '../../../services/community/community_service.dart';
import '../../../services/community/mock_community_service.dart';
import '../../common/app_components.dart';
import 'widgets/community_post_card.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String _category = '전체';

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: '필터 설정', caption: '정렬'),
                16.heightBox,
                FilterChipBar(
                  labels: const ['최신순', '인기순', '댓글순'],
                  selected: '최신순',
                  onSelected: (_) {},
                ),
                20.heightBox,
                const Text('지역', style: TextStyle(fontWeight: FontWeight.w800)),
                10.heightBox,
                FilterChipBar(
                  labels: const ['성수', '연남', '강남', '한남'],
                  selected: '성수',
                  onSelected: (_) {},
                ),
                24.heightBox,
                PrimaryButton(
                  label: '적용하기',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainShellPage(
      activeTab: AppTab.community,
      title: '커뮤니티',
      actions: [
        IconButton(
          onPressed: _showFilterSheet,
          icon: const Icon(LucideIcons.slidersHorizontal),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppPage.communityWrite.name),
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(LucideIcons.penLine),
      ),
      child: StreamBuilder<List<CommunityPost>>(
        stream: CommunityService.getPosts(category: _category),
        builder: (context, snapshot) {
          final posts = _postsFor(snapshot);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              FilterChipBar(
                labels: const ['전체', '메이트', '후기', '교환', '질문'],
                selected: _category,
                onSelected: (value) => setState(() => _category = value),
              ),
              24.heightBox,
              const SectionHeader(title: '인기 게시글', caption: 'Mate Board'),
              16.heightBox,
              if (snapshot.hasError)
                const Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: Text(
                    'Firestore 연결 전까지 mock 게시글을 표시합니다.',
                    style: TextStyle(color: AppColors.muted),
                  ),
                ),
              ...posts.map(
                (post) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: CommunityPostCard(post: post),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<CommunityPost> _postsFor(AsyncSnapshot<List<CommunityPost>> snapshot) {
    final firestorePosts = snapshot.data ?? const <CommunityPost>[];
    if (firestorePosts.isNotEmpty) return firestorePosts;

    final mockPosts = MockCommunityService.posts;
    if (_category == '전체') return mockPosts;
    return mockPosts.where((post) => post.category == _category).toList();
  }
}
