import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/mock_models.dart';

class CommunityService {
  CommunityService._();

  static final _db = FirebaseFirestore.instance;
  static const _collection = 'community_posts';

  /// 게시글 목록 가져오기 (실시간 Stream)
  static Stream<List<CommunityPost>> getPosts({
    String category = '전체',
    String sortBy = '최신순',
    String area = '전체',
  }) {
    Query query = _db.collection(_collection);

    // 1. 카테고리 필터
    if (category != '전체') {
      query = query.where('category', isEqualTo: category);
    }

    // 2. 지역 필터
    if (area != '전체') {
      query = query.where('area', isEqualTo: area);
    }

    // 3. 정렬 (Firestore 인덱스 생성 필요할 수 있음)
    switch (sortBy) {
      case '인기순':
        query = query.orderBy('likes', descending: true);
        break;
      case '댓글순':
        query = query.orderBy('comments', descending: true);
        break;
      default: // 최신순
        query = query.orderBy('createdAt', descending: true);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CommunityPost.fromFirestore(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    });
  }

  /// 게시글 작성
  static Future<void> addPost({
    required String title,
    required String body,
    required String category,
    required String area,
    required String popupTitle,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    final post = CommunityPost(
      id: '', // Firestore 자동 생성
      author: '사용자_${user.uid.substring(0, 4)}',
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

  /// 좋아요 토글 (트랜잭션 사용)
  static Future<void> toggleLike(String postId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = _db.collection(_collection).doc(postId);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) return;

      final data = snapshot.data() as Map<String, dynamic>;
      final List<String> likedBy = List<String>.from(data['likedBy'] ?? []);
      int likes = data['likes'] ?? 0;

      if (likedBy.contains(user.uid)) {
        likedBy.remove(user.uid);
        likes--;
      } else {
        likedBy.add(user.uid);
        likes++;
      }

      transaction.update(docRef, {
        'likedBy': likedBy,
        'likes': likes,
      });
    });
  }

  /// 특정 게시글 댓글 목록 (Stream)
  static Stream<List<CommunityComment>> getComments(String postId) {
    return _db
        .collection(_collection)
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CommunityComment.fromFirestore(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    });
  }

  /// 댓글 작성
  static Future<void> addComment(String postId, String body) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final comment = CommunityComment(
      id: '',
      author: '사용자_${user.uid.substring(0, 4)}',
      authorId: user.uid,
      body: body,
      createdAt: DateTime.now(),
    );

    final postRef = _db.collection(_collection).doc(postId);
    final commentRef = postRef.collection('comments').doc();

    await _db.runTransaction((transaction) async {
      transaction.set(commentRef, comment.toFirestore());
      transaction.update(postRef, {
        'comments': FieldValue.increment(1),
      });
    });
  }

  /// 초기 데이터 시딩 (테스트용)
  static Future<void> seedData() async {
    final snapshot = await _db.collection(_collection).limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    final mockPosts = [
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
        'likedBy': [],
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
        'likedBy': [],
        'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
      }
    ];

    for (var data in mockPosts) {
      await _db.collection(_collection).add(data);
    }
  }
}
