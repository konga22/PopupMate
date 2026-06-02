import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/community_models.dart';
import 'community_auth_session.dart';
import 'community_firestore_refs.dart';
import 'community_post_query.dart';
import 'community_seed_posts.dart';

class CommunityService {
  const CommunityService._();

  static Stream<List<CommunityPost>> getPosts({
    String category = '전체',
    String sortBy = '최신순',
    String area = '전체',
  }) {
    final query = CommunityPostQuery.build(
      collection: CommunityFirestoreRefs.posts,
      category: category,
      sortBy: sortBy,
      area: area,
    );

    return query.snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map((doc) => CommunityPost.fromFirestore(doc.id, doc.data()))
              .toList(),
    );
  }

  static Stream<CommunityPost?> getPost(String postId) {
    return CommunityFirestoreRefs.post(postId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return CommunityPost.fromFirestore(snapshot.id, data);
    });
  }

  static Future<void> addPost({
    required String title,
    required String body,
    required String category,
    required String area,
    required String popupTitle,
  }) async {
    final user = await CommunityAuthSession.currentUser();
    if (user == null) throw Exception('로그인이 필요합니다.');

    final post = CommunityPost(
      id: '',
      author: CommunityAuthSession.displayNameFor(user.uid),
      authorId: user.uid,
      timeAgo: '방금 전',
      category: category,
      title: title,
      popupTitle: popupTitle,
      body: body,
      likes: 0,
      comments: 0,
      status: category == '메이트' ? '모집중' : 'HOT',
      area: area,
      createdAt: DateTime.now(),
    );

    await CommunityFirestoreRefs.posts.add(post.toFirestore());
  }

  static Future<void> toggleLike(String postId) async {
    if (postId.startsWith('mock_')) return;

    final user = await CommunityAuthSession.currentUser();
    if (user == null) return;

    final docRef = CommunityFirestoreRefs.post(postId);

    await CommunityFirestoreRefs.db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) return;

      final data = snapshot.data() ?? <String, dynamic>{};
      final likedBy = List<String>.from(data['likedBy'] ?? const []);
      var likes = data['likes'] as int? ?? 0;

      if (likedBy.contains(user.uid)) {
        likedBy.remove(user.uid);
        likes = likes > 0 ? likes - 1 : 0;
      } else {
        likedBy.add(user.uid);
        likes++;
      }

      transaction.update(docRef, {'likedBy': likedBy, 'likes': likes});
    });
  }

  static bool isLikedByCurrentUser(CommunityPost post) {
    return CommunityAuthSession.isLikedByCurrentUser(post);
  }

  static Stream<List<CommunityComment>> getComments(String postId) {
    if (postId.startsWith('mock_')) {
      return Stream<List<CommunityComment>>.value(const []);
    }

    return CommunityFirestoreRefs.comments(postId)
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => CommunityComment.fromFirestore(doc.id, doc.data()),
                  )
                  .toList(),
        );
  }

  static Future<void> addComment(String postId, String body) async {
    if (postId.startsWith('mock_')) return;

    final user = await CommunityAuthSession.currentUser();
    if (user == null) return;

    final comment = CommunityComment(
      id: '',
      author: CommunityAuthSession.displayNameFor(user.uid),
      authorId: user.uid,
      body: body,
      createdAt: DateTime.now(),
    );

    final postRef = CommunityFirestoreRefs.post(postId);
    final commentRef = CommunityFirestoreRefs.comments(postId).doc();

    await CommunityFirestoreRefs.db.runTransaction((transaction) async {
      transaction.set(commentRef, comment.toFirestore());
      transaction.update(postRef, {'comments': FieldValue.increment(1)});
    });
  }

  static Future<void> seedData() async {
    final snapshot = await CommunityFirestoreRefs.posts.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    for (final post in communitySeedPosts) {
      await CommunityFirestoreRefs.posts.add(post);
    }
  }
}
