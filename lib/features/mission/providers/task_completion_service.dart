import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/providers/user_stats_provider.dart';
import '../providers/mission_provider.dart';

// タスク完了処理の結果
class TaskCompletionResult {
  final bool success;
  final bool leveledUp;
  final int? oldLevel;
  final int? newLevel;
  final int expGained;
  final bool missionCompleted; // ミッションの全タスクが完了したか

  TaskCompletionResult({
    required this.success,
    required this.leveledUp,
    this.oldLevel,
    this.newLevel,
    required this.expGained,
    this.missionCompleted = false,
  });
}

// タスク完了処理を統合するサービスクラス
class TaskCompletionService {
  final Ref _ref;

  TaskCompletionService(this._ref);

  // タスクを完了/未完了に切り替え、経験値を加算/減算
  Future<TaskCompletionResult> toggleTaskCompletion({
    required String missionId,
    required String taskId,
    required bool isCurrentlyCompleted,
    required int taskExp,
  }) async {
    // タスクの状態を切り替え（戻り値: 全タスクが完了したか）
    final allTasksCompleted = await _ref
        .read(missionListProvider.notifier)
        .toggleTask(missionId, taskId);

    final userStatsNotifier = _ref.read(userStatsProvider.notifier);
    final currentStats = _ref.read(userStatsProvider).value;

    if (currentStats == null) {
      return TaskCompletionResult(
        success: false,
        leveledUp: false,
        expGained: 0,
      );
    }

    // 完了→未完了の場合は経験値を減算
    if (isCurrentlyCompleted) {
      debugPrint(
        '🎯 TaskCompletionService: Subtracting $taskExp EXP (task uncomplete)',
      );
      await userStatsNotifier.subtractExperience(taskExp);

      return TaskCompletionResult(
        success: true,
        leveledUp: false,
        expGained: -taskExp, // 負の値で減算を表現
        missionCompleted: false, // 完了→未完了なのでミッション完了にはならない
      );
    }

    // 未完了→完了の場合は経験値を加算
    debugPrint('🎯 TaskCompletionService: Adding $taskExp EXP (task complete)');
    final oldLevel = currentStats.level;
    final leveledUp = await userStatsNotifier.addExperience(taskExp);
    final newStats = _ref.read(userStatsProvider).value;

    debugPrint(
      '🎯 TaskCompletionService: allTasksCompleted=$allTasksCompleted, leveledUp=$leveledUp',
    );

    return TaskCompletionResult(
      success: true,
      leveledUp: leveledUp,
      oldLevel: oldLevel,
      newLevel: newStats?.level,
      expGained: taskExp,
      missionCompleted: allTasksCompleted, // 全タスク完了ならtrue
    );
  }
}

// Provider定義
final taskCompletionServiceProvider = Provider<TaskCompletionService>((ref) {
  return TaskCompletionService(ref);
});
