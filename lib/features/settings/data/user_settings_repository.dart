import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/user_settings.dart';

class UserSettingsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestoreの users ドキュメント参照
  DocumentReference _userDoc(String uid) =>
      _firestore.collection('users').doc(uid);

  /// 設定を取得する。もしデータが存在しなければデフォルトの UserSettings を返す。
  Future<UserSettings> getSettings(String uid) async {
    final docSnap = await _userDoc(uid).get();

    if (docSnap.exists) {
      final data = docSnap.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('settings')) {
        return UserSettings.fromJson(data['settings'] as Map<String, dynamic>);
      }
    }
    // データがない（または settingsフィールドがない）場合は初期設定を返す
    return const UserSettings();
  }

  /// 設定をFirestoreに保存する
  Future<void> saveSettings(String uid, UserSettings settings) async {
    await _userDoc(uid).set({
      // merge: true にすることで既存の他のデータ（新規登録時に作成したフラグ等）を消さずに保存
      'settings': settings.toJson(),
    }, SetOptions(merge: true));
  }
}
