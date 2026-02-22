import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../domain/mission.dart';
import '../domain/task.dart';
import '../data/mission_repository.dart';

const _uuid = Uuid();

// ミッション一覧の状態を管理するNotifier
class MissionListNotifier extends StateNotifier<AsyncValue<List<Mission>>> {
  final MissionRepository _repository;

  MissionListNotifier(this._repository) : super(const AsyncValue.loading()) {
    debugPrint(
      '🎯 MissionListNotifier: Created with repository instance: ${_repository.hashCode}',
    );
    _loadMissions();
  }

  // ミッション一覧をロード
  Future<void> _loadMissions() async {
    state = const AsyncValue.loading();
    try {
      final missions = _repository.getActiveMissions();
      debugPrint('🔍 MissionListNotifier: Loaded ${missions.length} missions');
      for (var mission in missions) {
        debugPrint('  - ${mission.title} (${mission.tasks.length} tasks)');
      }
      state = AsyncValue.data(missions);
    } catch (e, stack) {
      debugPrint('❌ MissionListNotifier: Error loading missions: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  // 新しいミッションを追加
  Future<void> addMission({
    required String name,
    required List<Map<String, dynamic>> tasks,
  }) async {
    try {
      debugPrint(
        '➕ MissionListNotifier: Adding mission "$name" with ${tasks.length} tasks',
      );

      final taskList = tasks
          .map(
            (taskData) => Task(
              id: _uuid.v4(),
              title: taskData['name'] as String,
              isCompleted: false,
              exp: taskData['exp'] as int? ?? 250,
            ),
          )
          .toList();

      final mission = Mission(
        id: _uuid.v4(),
        title: name,
        tasks: taskList,
        createdAt: DateTime.now(),
      );

      await _repository.addMission(mission);
      debugPrint('✅ MissionListNotifier: Mission saved to repository');

      await _loadMissions();
      debugPrint('🔄 MissionListNotifier: Missions reloaded');
    } catch (e, stack) {
      debugPrint('❌ MissionListNotifier: Error adding mission: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  // ミッションを更新
  Future<void> updateMission(Mission mission) async {
    try {
      await _repository.updateMission(mission);
      await _loadMissions();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // ミッションを削除
  Future<void> deleteMission(String missionId) async {
    try {
      await _repository.deleteMission(missionId);
      await _loadMissions();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // タスクの完了状態を切り替え（ミッション完了処理は行わない）
  // 戻り値: 全タスクが完了したかどうか
  Future<bool> toggleTask(String missionId, String taskId) async {
    final missions = state.value;
    if (missions == null) return false;

    try {
      // 対象のミッションを見つける
      final missionIndex = missions.indexWhere((m) => m.id == missionId);
      if (missionIndex == -1) return false;

      final mission = missions[missionIndex];

      // 対象のタスクを見つける
      final taskIndex = mission.tasks.indexWhere((t) => t.id == taskId);
      if (taskIndex == -1) return false;

      final task = mission.tasks[taskIndex];

      // タスクの完了状態を切り替え
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

      // タスクリストを更新
      final updatedTasks = List<Task>.from(mission.tasks);
      updatedTasks[taskIndex] = updatedTask;

      // ミッション全体を更新（completedAtは設定しない）
      // ミッション完了処理は completeMission() で別途行う
      final updatedMission = mission.copyWith(tasks: updatedTasks);

      await _repository.updateMission(updatedMission);
      await _loadMissions();

      // 全タスクが完了したかどうかを返す
      return updatedTasks.every((t) => t.isCompleted);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  // ミッションを完了状態にする（タスクカードをクリアする）
  Future<void> completeMission(
    String missionId, {
    int? levelBefore,
    int? levelAfter,
  }) async {
    final missions = state.value;
    if (missions == null) return;

    try {
      final missionIndex = missions.indexWhere((m) => m.id == missionId);
      if (missionIndex == -1) return;

      final mission = missions[missionIndex];

      // 既に完了している場合は何もしない
      if (mission.completedAt != null) return;

      debugPrint(
        '🎯 MissionListNotifier: Completing mission "${mission.title}"',
      );

      final updatedMission = mission.copyWith(
        completedAt: DateTime.now(),
        levelBeforeCompletion: levelBefore,
        levelAfterCompletion: levelAfter,
      );
      await _repository.updateMission(updatedMission);
      await _loadMissions();

      debugPrint(
        '✅ MissionListNotifier: Mission completed and removed from active list',
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // 手動リロード
  Future<void> reload() async {
    await _loadMissions();
  }
}

// Provider定義
final missionListProvider =
    StateNotifierProvider<MissionListNotifier, AsyncValue<List<Mission>>>((
      ref,
    ) {
      final repository = ref.watch(missionRepositoryProvider);
      return MissionListNotifier(repository);
    });

// 便利なヘルパーProvider（アクティブミッション数を取得）
final activeMissionCountProvider = Provider<int>((ref) {
  final missionsAsync = ref.watch(missionListProvider);
  return missionsAsync.value?.length ?? 0;
});

// 便利なヘルパーProvider（特定のミッションを取得）
final missionByIdProvider = Provider.family<Mission?, String>((ref, missionId) {
  final missionsAsync = ref.watch(missionListProvider);
  final missions = missionsAsync.value;
  if (missions == null) return null;

  try {
    return missions.firstWhere((m) => m.id == missionId);
  } catch (_) {
    return null;
  }
});

// 完了済みミッション一覧Provider（履歴用）
// 「鵺」ミッションの completedAt をカットオフ基準として使用。
// タイトルに加えて作成日時（2026-02-22より前）も条件にすることで
// 将来同名のミッションを作成してもカットオフ基準がズレない。
// 「鵺」が存在しない場合（他ユーザー等）は全件表示。
// missionListProvider を watch することで、ミッション完了時に自動的に再評価される

// ▼ デバッグ用: true にすると空状態画面を確認できる
const _debugEmptyHistory = false;

final missionHistoryProvider = Provider<List<Mission>>((ref) {
  if (_debugEmptyHistory) return [];

  ref.watch(missionListProvider); // 変更検知トリガー
  final repository = ref.watch(missionRepositoryProvider);
  final all = repository.getCompletedMissions();

  // カットオフ基準ミッションを検索
  // タイトル「鵺」かつ 2026-02-22 より前に作成されたものに限定
  final pivotDeadline = DateTime(2026, 2, 22);
  final pivot = all
      .where(
        (m) =>
            m.title == '鵺' &&
            m.completedAt != null &&
            m.createdAt.isBefore(pivotDeadline),
      )
      .firstOrNull;

  // 見つからなければ全件返す（他ユーザー向け）
  if (pivot == null) return all;

  // 「鵺」の完了日時以降のみ返す
  return all
      .where(
        (m) =>
            m.completedAt != null &&
            !m.completedAt!.isBefore(pivot.completedAt!),
      )
      .toList();
});
