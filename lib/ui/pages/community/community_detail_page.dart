import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/theme/app_theme.dart';
import '../../../models/mock_models.dart';
import '../../../services/community_service.dart';
import '../../common/app_components.dart';

class CommunityDetailPage extends StatefulWidget {
  const CommunityDetailPage({super.key, required this.postId});

  final String postId;

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  final _commentController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onAddComment() {
    if (_commentController.text.trim().isEmpty) return;
    CommunityService.addComment(widget.postId, _commentController.text.trim());
    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: '게시글', showBack: true),
      body: StreamBuilder<List<CommunityPost>>(
        stream: CommunityService.getPosts(), // 전체 스트림에서 하나만 찾거나 단일 문서 스트림 사용 가능
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          // 해당 ID의 포스트 찾기 (실제로는 단일 문서 fetch가 더 효율적이지만 구조상 getPosts 재사용)
          final post = snapshot.data!.firstWhere((p) => p.id == widget.postId, 
              orElse: () => snapshot.data!.first);

          final isLiked = post.likedBy.contains(_currentUser?.uid);

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
                        Text(post.timeAgo, style: const TextStyle(color: AppColors.muted)),
                      ],
                    ),
                    16.heightBox,
                    Text(
                      post.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    8.heightBox,
                    Text(post.popupTitle, style: const TextStyle(color: AppColors.muted)),
                    24.heightBox,
                    Text(
                      post.body,
                      style: const TextStyle(fontSize: 16, height: 1.6, color: AppColors.body),
                    ),
                    32.heightBox,
                    const Divider(color: AppColors.softBorder),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => CommunityService.toggleLike(post.id),
                          icon: Icon(
                            isLiked ? LucideIcons.heart : LucideIcons.heart,
                            color: isLiked ? AppColors.danger : AppColors.muted,
                            fill: isLiked ? AppColors.danger.value.toDouble() : 0, // 실제 fill 속성 여부 확인 필요
                          ),
                        ),
                        Text('${post.likes}명 이 좋아합니다'),
                        const Spacer(),
                        const Icon(LucideIcons.messageCircle, size: 20, color: AppColors.muted),
                        5.widthBox,
                        Text('댓글 ${post.comments}'),
                      ],
                    ),
                    24.heightBox,
                    const SectionHeader(title: '댓글', caption: 'Comments'),
                    16.heightBox,
                    StreamBuilder<List<CommunityComment>>(
                      stream: CommunityService.getComments(post.id),
                      builder: (context, commentSnapshot) {
                        if (!commentSnapshot.hasData) return const SizedBox();
                        final comments = commentSnapshot.data!;
                        if (comments.isEmpty) return const Center(child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('첫 댓글을 남겨보세요!'),
                        ));

                        return Column(
                          children: comments.map((c) => _CommentTile(comment: c)).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              _CommentInput(
                controller: _commentController,
                onSend: _onAddComment,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});
  final CommunityComment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceAlt,
            child: Text(comment.author[0], style: const TextStyle(fontSize: 12)),
          ),
          12.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.author, style: const TextStyle(fontWeight: FontWeight.w800)),
                4.heightBox,
                Text(comment.body, style: const TextStyle(color: AppColors.body)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInput extends StatelessWidget {
  const _CommentInput({required this.controller, required this.onSend});
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20, 
        12, 
        20, 
        MediaQuery.of(context).padding.bottom + 12
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.softBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '댓글을 입력하세요...',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          12.widthBox,
          IconButton(
            onPressed: onSend,
            icon: const Icon(LucideIcons.send, color: AppColors.ink),
          ),
        ],
      ),
    );
  }
}
