import 'package:flutter/material.dart';

/// アニメーションの種類
enum AnimationType {
  levelUp, // 最優先：レベルアップモーダル
  expGain, // 中優先：EXP獲得フィードバック
  progressBar, // 低優先：プログレスバーアニメーション
  taskComplete, // 低優先：タスク完了フィードバック
}

/// アニメーションの優先度
enum AnimationPriority {
  high, // 他のアニメーションを中断して即座に実行
  medium, // 実行中のアニメーション終了後に実行
  low, // キューの最後に追加
}

/// アニメーションタスク
class AnimationTask {
  final String id;
  final AnimationType type;
  final AnimationPriority priority;
  final VoidCallback onExecute;
  final VoidCallback? onComplete;
  final Duration? estimatedDuration;

  AnimationTask({
    required this.id,
    required this.type,
    required this.priority,
    required this.onExecute,
    this.onComplete,
    this.estimatedDuration,
  });

  @override
  String toString() {
    return 'AnimationTask(id: $id, type: $type, priority: $priority)';
  }
}
