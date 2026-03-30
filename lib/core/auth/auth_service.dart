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

  /// 現在のパスワードで再認証（セキュリティ操作の前に必要）
  Future<void> reauthenticate(String password) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No authenticated user found.',
      );
    }
    debugPrint('🔑 Auth: Reauthenticating uid=${user.uid}');
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
    debugPrint('🔑 Auth: Reauthentication successful. uid=${user.uid}');
  }

  /// パスワード変更（事前に reauthenticate を呼ぶこと）
  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No authenticated user found.',
      );
    }
    debugPrint('🔑 Auth: Changing password for uid=${user.uid}');
    await user.updatePassword(newPassword);
    debugPrint('🔑 Auth: Password changed successfully. uid=${user.uid}');
  }

  /// アカウント削除（事前に reauthenticate を呼ぶこと）
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No authenticated user found.',
      );
    }
    debugPrint('⚠️ Auth: Deleting account. uid=${user.uid}');
    await user.delete();
    debugPrint('🗑️ Auth: Account deleted. uid=${user.uid}');
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
