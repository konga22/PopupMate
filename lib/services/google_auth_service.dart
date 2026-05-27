import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  const GoogleAuthService._();

  static final _googleSignIn = GoogleSignIn();

  static Future<UserCredential?> signIn() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // 사용자가 취소

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      FirebaseAuth.instance.signOut(),
    ]);
  }
}
