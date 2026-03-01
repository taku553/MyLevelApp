import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 現在サインイン済みのユーザーを返す（未サインインの場合はnull）
  User? get currentUser => _auth.currentUser;

  /// UIDを返す（未サインインの場合はnull）
  String? get uid => _auth.currentUser?.uid;

  /// メール/パスワードで新規登録
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('🔑 Auth: Signed up with email. uid=${credential.user?.uid}');
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Auth: Sign up failed. code=${e.code}');
      rethrow;
    }
  }

  /// メール/パスワードでログイン
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('🔑 Auth: Signed in with email. uid=${credential.user?.uid}');
      return credential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Auth: Sign in failed. code=${e.code}');
      rethrow;
    }
  }

  /// サインアウト
  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint('🔑 Auth: Signed out');
  }

  /// 認証状態の変化を監視するStream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}

// Riverpod Provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// 認証状態をリアルタイムで監視するStreamProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

/// 現在のUID（未サインイン時はnull）
final currentUidProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).value?.uid;
});
