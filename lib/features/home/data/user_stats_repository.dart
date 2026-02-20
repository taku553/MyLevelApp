import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user_stats.dart';

class UserStatsRepository {
  static const String _boxName = 'userStats';
  static const String _statsKey = 'stats';
  Box<UserStats>? _box;

  // Boxの初期化
  Future<void> init() async {
    debugPrint('🔧 UserStatsRepository: Initializing...');
    _box = await Hive.openBox<UserStats>(_boxName);
    debugPrint(
      '🔧 UserStatsRepository: Initialized. Box has ${_box?.length ?? 0} stats',
    );
  }

  // UserStats取得（初回はデフォルト値）
  UserStats getStats() {
    return _box?.get(_statsKey) ?? const UserStats();
  }

  // UserStats保存
  Future<void> saveStats(UserStats stats) async {
    await _box?.put(_statsKey, stats);
  }

  // 経験値加算とレベルアップ処理
  Future<UserStats> addExp(int exp) async {
    UserStats currentStats = getStats();
    int newExp = currentStats.currentExp + exp;
    int newLevel = currentStats.level;
    int requiredExp = currentStats.nextLevelExp;

    // レベルアップ判定（複数レベルアップにも対応）
    while (newExp >= requiredExp) {
      newExp -= requiredExp;
      newLevel++;
      requiredExp = _calculateNextLevelExp(newLevel);
    }

    final updatedStats = UserStats(
      level: newLevel,
      currentExp: newExp,
      nextLevelExp: requiredExp,
    );

    await saveStats(updatedStats);
    return updatedStats;
  }

  // 経験値減算（レベルダウンなし、0でクリップ）
  Future<UserStats> subtractExp(int exp) async {
    UserStats currentStats = getStats();
    // 現在のレベル内でのみ減算（0未満にはならない）
    int newExp = (currentStats.currentExp - exp).clamp(
      0,
      currentStats.currentExp,
    );

    final updatedStats = UserStats(
      level: currentStats.level,
      currentExp: newExp,
      nextLevelExp: currentStats.nextLevelExp,
    );

    await saveStats(updatedStats);
    return updatedStats;
  }

  // 次レベルに必要な経験値を計算（線形増加）
  int _calculateNextLevelExp(int level) {
    return 100 + (level - 1) * 50; // Level 1→2: 100, Level 2→3: 150...
  }
}

// Riverpod Provider
final userStatsRepositoryProvider = Provider<UserStatsRepository>((ref) {
  return UserStatsRepository();
});
