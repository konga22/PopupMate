import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/mock_models.dart';

class CommunityService {
  const CommunityService._();

  static final _db = FirebaseFirestore.instance;
  static const _collection = 'community_posts';

  static Stream<List<CommunityPost>> getPosts({
    String category = '전체',
    String sortBy = '최신순',
    String area = '전체',
  }) {
    Query<Map<String, dynamic>> query = _db.collection(_collection);

    if (category != '전체') {
      query = query.where('category', isEqualTo: category);
    }

    if (area != '전체') {
      query = query.where('area', isEqualTo: area);
    }

    query = switch (sortBy) {
      '인기순' => query.orderBy('likes', descending: true),
      '댓글순' => query.orderBy('comments', descending: true),
      _ => query.orderBy('createdAt', descending: true),
    };

    return query.snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map((doc) => CommunityPost.fromFirestore(doc.id, doc.data()))
              .toList(),
    );
  }

  static Stream<CommunityPost?> getPost(String postId) {
    return _db.collection(_collection).doc(postId).snapshots().map((snapshot) {
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
    final user = await _currentUser();
    if (user == null) throw Exception('로그인이 필요합니다.');

    final post = CommunityPost(
      id: '',
      author: _displayNameFor(user.uid),
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

    await _db.collection(_collection).add(post.toFirestore());
  }

  static Future<void> toggleLike(String postId) async {
    if (postId.startsWith('mock_')) return;

    final user = await _currentUser();
    if (user == null) return;

    final docRef = _db.collection(_collection).doc(postId);

    await _db.runTransaction((transaction) async {
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

  static Stream<List<CommunityComment>> getComments(String postId) {
    if (postId.startsWith('mock_')) {
      return Stream<List<CommunityComment>>.value(const []);
    }

    return _db
        .collection(_collection)
        .doc(postId)
        .collection('comments')
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

    final user = await _currentUser();
    if (user == null) return;

    final comment = CommunityComment(
      id: '',
      author: _displayNameFor(user.uid),
      authorId: user.uid,
      body: body,
      createdAt: DateTime.now(),
    );

    final postRef = _db.collection(_collection).doc(postId);
    final commentRef = postRef.collection('comments').doc();

    await _db.runTransaction((transaction) async {
      transaction.set(commentRef, comment.toFirestore());
      transaction.update(postRef, {'comments': FieldValue.increment(1)});
    });
  }

  static Future<void> seedData() async {
    final snapshot = await _db.collection(_collection).limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    for (final post in _seedPosts) {
      await _db.collection(_collection).add(post);
    }
  }

  static String _displayNameFor(String uid) {
    final suffix = uid.length <= 4 ? uid : uid.substring(0, 4);
    return '사용자_$suffix';
  }

  static Future<User?> _currentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) return currentUser;

    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      return credential.user;
    } catch (_) {
      return null;
    }
  }

  static final _seedPosts = [
    {
      'author': '김민지',
      'authorId': 'mock_1',
      'category': '메이트',
      'title': '탬버린즈 성수 워크숍 같이 가실 분!',
      'popupTitle': 'Tamburins Seongsu',
      'body': '이번 주말 성수동 팝업 같이 돌면서 사진 찍고 이야기하실 분 찾아요.',
      'likes': 12,
      'comments': 2,
      'status': '2/4 모집중',
      'area': '성수',
      'likedBy': <String>[],
      'createdAt': DateTime.now().subtract(const Duration(hours: 1)),
    },
    {
      'author': '박알렉스',
      'authorId': 'mock_2',
      'category': '후기',
      'title': 'Dior Concept Store는 오전 방문 추천',
      'popupTitle': 'Dior Concept Store',
      'body': '전시가 정말 아름다웠어요. 오전 일찍 방문하시는 것을 강력 추천합니다.',
      'likes': 45,
      'comments': 5,
      'status': 'HOT',
      'area': '성수',
      'likedBy': <String>[],
      'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
    },
  ];
}
