import 'dart:async';
import 'package:flutter/foundation.dart';
import 'animation_types.dart';

/// アニメーションの競合を防ぎ、順序通りに実行する中央管理システム
class AnimationCoordinator {
  // アニメーションキュー
  final List<AnimationTask> _queue = [];

  // 現在実行中のアニメーション
  AnimationTask? _currentTask;

  // 実行中かどうか
  bool get isAnimating => _currentTask != null;

  // 現在のタスクタイプ
  AnimationType? get currentAnimationType => _currentTask?.type;

  /// アニメーションをキューに追加
  void enqueue(AnimationTask task) {
    debugPrint(
      '🎬 AnimationCoordinator: Enqueuing ${task.type} (priority: ${task.priority})',
    );

    if (task.priority == AnimationPriority.high) {
      // 高優先度：実行中のアニメーションをキャンセルして即座に実行
      if (_currentTask != null) {
        debugPrint(
          '🎬 AnimationCoordinator: Cancelling current task for high priority',
        );
        _cancelCurrentTask();
      }
      _queue.insert(0, task);
    } else if (task.priority == AnimationPriority.medium) {
      // 中優先度：キューの先頭に追加（低優先度より前）
      final lowPriorityIndex = _queue.indexWhere(
        (t) => t.priority == AnimationPriority.low,
      );
      if (lowPriorityIndex != -1) {
        _queue.insert(lowPriorityIndex, task);
      } else {
        _queue.add(task);
      }
    } else {
      // 低優先度：キューの最後に追加
      _queue.add(task);
    }

    // キューが空でなく、実行中のタスクがなければ処理開始
    if (!isAnimating) {
      _processQueue();
    }
  }

  /// キューからアニメーションを実行
  Future<void> _processQueue() async {
    while (_queue.isNotEmpty) {
      _currentTask = _queue.removeAt(0);

      if (_currentTask == null) continue;

      debugPrint('🎬 AnimationCoordinator: Executing ${_currentTask!.type}');

      // アニメーション実行
      _currentTask!.onExecute();

      // 推定時間が指定されていれば待機
      if (_currentTask!.estimatedDuration != null) {
        await Future.delayed(_currentTask!.estimatedDuration!);
      } else {
        // デフォルトは短い待機時間
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // 完了コールバック
      _currentTask!.onComplete?.call();

      debugPrint('🎬 AnimationCoordinator: Completed ${_currentTask!.type}');
      _currentTask = null;
    }
  }

  /// 実行中のアニメーションをキャンセル
  void _cancelCurrentTask() {
    if (_currentTask != null) {
      debugPrint('🎬 AnimationCoordinator: Cancelling ${_currentTask!.type}');
      _currentTask = null;
    }
  }

  /// 特定のタイプのアニメーションをキャンセル
  void cancelType(AnimationType type) {
    debugPrint('🎬 AnimationCoordinator: Cancelling all $type animations');

    // キューから削除
    _queue.removeWhere((task) => task.type == type);

    // 実行中のタスクもキャンセル
    if (_currentTask?.type == type) {
      _cancelCurrentTask();
    }
  }

  /// すべてのアニメーションをキャンセル
  void cancelAll() {
    debugPrint('🎬 AnimationCoordinator: Cancelling all animations');
    _queue.clear();
    _cancelCurrentTask();
  }

  /// キューをクリア（実行中のタスクは継続）
  void clearQueue() {
    debugPrint('🎬 AnimationCoordinator: Clearing queue');
    _queue.clear();
  }

  /// 特定のタイプのアニメーションが実行中またはキューにあるかチェック
  bool hasAnimation(AnimationType type) {
    return _currentTask?.type == type ||
        _queue.any((task) => task.type == type);
  }

  /// デバッグ情報
  void printStatus() {
    debugPrint('🎬 AnimationCoordinator Status:');
    debugPrint('  Current: ${_currentTask?.type ?? "none"}');
    debugPrint('  Queue: ${_queue.map((t) => t.type).toList()}');
  }
}
