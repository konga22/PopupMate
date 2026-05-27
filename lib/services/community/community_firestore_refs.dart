import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityFirestoreRefs {
  const CommunityFirestoreRefs._();

  static final db = FirebaseFirestore.instance;
  static const postsCollection = 'community_posts';

  static CollectionReference<Map<String, dynamic>> get posts {
    return db.collection(postsCollection);
  }

  static DocumentReference<Map<String, dynamic>> post(String postId) {
    return posts.doc(postId);
  }

  static CollectionReference<Map<String, dynamic>> comments(String postId) {
    return post(postId).collection('comments');
  }
}
