class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.author,
    required this.authorId,
    required this.timeAgo,
    required this.category,
    required this.title,
    required this.popupTitle,
    required this.body,
    required this.likes,
    required this.comments,
    required this.status,
    required this.area,
    this.likedBy = const [],
    this.createdAt,
  });

  final String id;
  final String author;
  final String authorId;
  final String timeAgo;
  final String category;
  final String title;
  final String popupTitle;
  final String body;
  final int likes;
  final int comments;
  final String status;
  final String area;
  final List<String> likedBy;
  final DateTime? createdAt;

  factory CommunityPost.fromFirestore(String id, Map<String, dynamic> data) {
    return CommunityPost(
      id: id,
      author: data['author'] ?? '익명',
      authorId: data['authorId'] ?? '',
      timeAgo: data['timeAgo'] ?? '방금 전',
      category: data['category'] ?? '전체',
      title: data['title'] ?? '',
      popupTitle: data['popupTitle'] ?? '',
      body: data['body'] ?? '',
      likes: data['likes'] ?? 0,
      comments: data['comments'] ?? 0,
      status: data['status'] ?? '',
      area: data['area'] ?? '전체',
      likedBy: List<String>.from(data['likedBy'] ?? const []),
      createdAt: _dateTimeFrom(data['createdAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'author': author,
    'authorId': authorId,
    'timeAgo': timeAgo,
    'category': category,
    'title': title,
    'popupTitle': popupTitle,
    'body': body,
    'likes': likes,
    'comments': comments,
    'status': status,
    'area': area,
    'likedBy': likedBy,
    'createdAt': createdAt ?? DateTime.now(),
  };
}

class CommunityComment {
  const CommunityComment({
    required this.id,
    required this.author,
    required this.authorId,
    required this.body,
    this.createdAt,
  });

  final String id;
  final String author;
  final String authorId;
  final String body;
  final DateTime? createdAt;

  factory CommunityComment.fromFirestore(String id, Map<String, dynamic> data) {
    return CommunityComment(
      id: id,
      author: data['author'] ?? '익명',
      authorId: data['authorId'] ?? '',
      body: data['body'] ?? '',
      createdAt: _dateTimeFrom(data['createdAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'author': author,
    'authorId': authorId,
    'body': body,
    'createdAt': createdAt ?? DateTime.now(),
  };
}

DateTime? _dateTimeFrom(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  return (value as dynamic).toDate() as DateTime?;
}
