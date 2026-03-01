import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user_stats.dart';
import '../data/user_stats_repository.dart';

// UserStatsの状態を管理するNotifier
class UserStatsNotifier extends StateNotifier<AsyncValue<UserStats>> {
  final UserStatsRepository _repository;
  StreamSubscription<UserStats>? _subscription;

  UserStatsNotifier(this._repository) : super(const AsyncValue.loading()) {
    // まそulローカルデータを表示（高速）
    _loadFromLocal();
    // 次にFirestoreリアルタイムストリームを購読
    _listenToFirestore();
  }

  // Hiveキャッシュから即座に表示
  void _loadFromLocal() {
    try {
      final stats = _repository.getStats();
      state = AsyncValue.data(stats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Firestoreリアルタイムストリームを購読
  // 他デバイスでの変更が即座に反映される
  void _listenToFirestore() {
    _subscription = _repository.statsStream.listen(
      (stats) {
        state = AsyncValue.data(stats);
      },
      onError: (e, stack) {
        // ストリームエラー時は現在の状態を維持し続ける
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // 経験値を加算（レベルアップ処理も含む）
  Future<bool> addExperience(int exp) async {
    final currentStats = state.value;
    if (currentStats == null) return false;

    try {
      // レベルアップ前のレベルを記録
      final oldLevel = currentStats.level;

      // 経験値加算とレベルアップ処理
      final updatedStats = await _repository.addExp(exp);

      // 状態を更新（Firestoreストリームからも更新が来るが、ローカルを優先）
      state = AsyncValue.data(updatedStats);

      // レベルアップしたかどうかを返す
      return updatedStats.level > oldLevel;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  // 経験値を減算（レベルダウンなし）
  Future<void> subtractExperience(int exp) async {
    final currentStats = state.value;
    if (currentStats == null) return;

    try {
      // 経験値減算（0でクリップ）
      final updatedStats = await _repository.subtractExp(exp);

      // 状態を更新
      state = AsyncValue.data(updatedStats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // 統計情報をリセット（デバッグ用）
  Future<void> resetStats() async {
    try {
      const defaultStats = UserStats();
      await _repository.saveStats(defaultStats);
      state = const AsyncValue.data(defaultStats);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // 手動リロード（Hiveキャッシュを再読んで現在状態を表示）
  Future<void> reload() async {
    _loadFromLocal();
  }
}

// Provider定義
final userStatsProvider =
    StateNotifierProvider<UserStatsNotifier, AsyncValue<UserStats>>((ref) {
      final repository = ref.watch(userStatsRepositoryProvider);
      return UserStatsNotifier(repository);
    });

// 便利なヘルパーProvider（レベルのみを取得）
final userLevelProvider = Provider<int>((ref) {
  final statsAsync = ref.watch(userStatsProvider);
  return statsAsync.value?.level ?? 1;
});

// 便利なヘルパーProvider（経験値の進捗率を取得 0.0〜1.0）
final expProgressProvider = Provider<double>((ref) {
  final statsAsync = ref.watch(userStatsProvider);
  final stats = statsAsync.value;
  if (stats == null) return 0.0;

  return stats.currentExp / stats.nextLevelExp;
});
