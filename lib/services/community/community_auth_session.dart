import 'package:firebase_auth/firebase_auth.dart';

import '../../models/community_models.dart';

class CommunityAuthSession {
  const CommunityAuthSession._();

  static bool isLikedByCurrentUser(CommunityPost post) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return uid != null && post.likedBy.contains(uid);
  }

  static String displayNameFor(String uid) {
    final suffix = uid.length <= 4 ? uid : uid.substring(0, 4);
    return '사용자_$suffix';
  }

  static Future<User?> currentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) return currentUser;

    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      return credential.user;
    } catch (_) {
      return null;
    }
  }
}
