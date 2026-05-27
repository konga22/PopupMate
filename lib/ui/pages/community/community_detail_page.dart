import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../models/community_models.dart';
import '../../../services/community/community_service.dart';
import '../../../services/community/mock_community_service.dart';
import '../../common/app_components.dart';
import 'widgets/community_detail_content.dart';

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

          return CommunityDetailContent(
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
