import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/router/app_page.dart';
import '../../../app/router/app_tab.dart';
import '../../../app/theme/app_theme.dart';
import '../../../models/mock_models.dart';
import '../../../services/community_service.dart';
import '../../common/app_components.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String _category = '전체';
  String _sortBy = '최신순';
  String _area = '전체';

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) => _FilterSheet(
        initialSortBy: _sortBy,
        initialArea: _area,
        onApply: (sort, area) {
          setState(() {
            _sortBy = sort;
            _area = area;
          });
        },
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
        stream: CommunityService.getPosts(
          category: _category,
          sortBy: _sortBy,
          area: _area,
        ),
        builder: (context, snapshot) {
          final posts = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              FilterChipBar(
                labels: const ['전체', '메이트', '후기', '교환', '질문'],
                selected: _category,
                onSelected: (value) => setState(() => _category = value),
              ),
              24.heightBox,
              SectionHeader(
                title: _category == '전체' ? '인기 게시글' : '$_category 게시글',
                caption: 'Mate Board',
              ),
              16.heightBox,
              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ))
              else if (posts.isEmpty)
                const EmptyPlaceholder(
                  title: '게시글이 없습니다',
                  message: '가장 먼저 첫 번째 소식을 남겨보세요!',
                  icon: LucideIcons.messageSquareDashed,
                )
              else
                ...posts.map(
                  (post) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _PostCard(
                      post: post,
                      onTap: () => context.pushNamed(
                        AppPage.communityDetail.name,
                        pathParameters: {'postId': post.id},
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({
    required this.initialSortBy,
    required this.initialArea,
    required this.onApply,
  });

  final String initialSortBy;
  final String initialArea;
  final Function(String sortBy, String area) onApply;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String _tempSort;
  late String _tempArea;

  @override
  void initState() {
    super.initState();
    _tempSort = widget.initialSortBy;
    _tempArea = widget.initialArea;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: '필터 설정', caption: '정렬'),
          16.heightBox,
          FilterChipBar(
            labels: const ['최신순', '인기순', '댓글순'],
            selected: _tempSort,
            onSelected: (val) => setState(() => _tempSort = val),
          ),
          20.heightBox,
          const Text('지역', style: TextStyle(fontWeight: FontWeight.w800)),
          10.heightBox,
          FilterChipBar(
            labels: const ['전체', '성수', '연남', '강남', '한남'],
            selected: _tempArea,
            onSelected: (val) => setState(() => _tempArea = val),
          ),
          24.heightBox,
          PrimaryButton(
            label: '적용하기',
            onPressed: () {
              widget.onApply(_tempSort, _tempArea);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post, required this.onTap});

  final CommunityPost post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
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
            Text(post.popupTitle, style: const TextStyle(color: AppColors.muted)),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
