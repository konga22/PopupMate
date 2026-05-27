import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/extensions/spacing_extension.dart';
import '../../../app/theme/app_theme.dart';
import '../../../models/mock_models.dart';
import '../../../services/community_service.dart';
import '../../../services/mock_community_service.dart';
import '../../common/app_components.dart';

class CommunityDetailPage extends StatefulWidget {
  const CommunityDetailPage({super.key, required this.postId});

  final String postId;

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _onAddComment() async {
    final body = _commentController.text.trim();
    if (body.isEmpty) return;

    await CommunityService.addComment(widget.postId, body);
    if (!mounted) return;

    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: '게시글', showBack: true),
      body: StreamBuilder<CommunityPost?>(
        stream: CommunityService.getPost(widget.postId),
        builder: (context, snapshot) {
          final fallbackPost = _mockPostFor(widget.postId);
          final post = snapshot.data ?? fallbackPost;

          if (snapshot.connectionState == ConnectionState.waiting &&
              post == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (post == null) {
            return const EmptyPlaceholder(
              title: '게시글을 찾을 수 없습니다',
              message: '삭제되었거나 접근할 수 없는 게시글입니다.',
              icon: LucideIcons.messageCircleOff,
            );
          }

          return _CommunityDetailContent(
            post: post,
            onAddComment: _onAddComment,
            commentController: _commentController,
          );
        },
      ),
    );
  }

  CommunityPost? _mockPostFor(String postId) {
    for (final post in MockCommunityService.posts) {
      if (post.id == postId) return post;
    }
    return null;
  }
}

class _CommunityDetailContent extends StatelessWidget {
  const _CommunityDetailContent({
    required this.post,
    required this.onAddComment,
    required this.commentController,
  });

  final CommunityPost post;
  final VoidCallback onAddComment;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isLiked = post.likedBy.contains(currentUser?.uid);

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
                            .map((comment) => _CommentTile(comment: comment))
                            .toList(),
                  );
                },
              ),
            ],
          ),
        ),
        _CommentInput(controller: commentController, onSend: onAddComment),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

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

class _CommentInput extends StatelessWidget {
  const _CommentInput({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 12),
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
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
