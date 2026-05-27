import 'package:flutter/material.dart';

import '../../../../app/extensions/spacing_extension.dart';
import '../../../../models/community_models.dart';
import '../../../../services/community_service.dart';
import '../../../common/app_components.dart';
import 'comment_tile.dart';

class CommunityCommentsSection extends StatelessWidget {
  const CommunityCommentsSection({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '댓글', caption: 'Comments'),
        16.heightBox,
        StreamBuilder<List<CommunityComment>>(
          stream: CommunityService.getComments(postId),
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
    );
  }
}
