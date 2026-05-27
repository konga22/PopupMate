import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPostQuery {
  const CommunityPostQuery._();

  static Query<Map<String, dynamic>> build({
    required CollectionReference<Map<String, dynamic>> collection,
    required String category,
    required String sortBy,
    required String area,
  }) {
    Query<Map<String, dynamic>> query = collection;

    if (category != '전체') {
      query = query.where('category', isEqualTo: category);
    }

    if (area != '전체') {
      query = query.where('area', isEqualTo: area);
    }

    return switch (sortBy) {
      '인기순' => query.orderBy('likes', descending: true),
      '댓글순' => query.orderBy('comments', descending: true),
      _ => query.orderBy('createdAt', descending: true),
    };
  }
}
