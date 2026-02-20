import 'package:flutter/material.dart';

/// 円形プログレスバーのアニメーションコントローラー
/// 滑らかなイージングとパルスエフェクトを提供
class ProgressAnimationController {
  final TickerProvider vsync;
  late final AnimationController _progressController;
  late final AnimationController _pulseController;
  late final Animation<double> _progressAnimation;
  late final Animation<double> _pulseAnimation;

  double _currentProgress = 0.0;
  double _targetProgress = 0.0;

  ProgressAnimationController({
    required this.vsync,
    Duration progressDuration = const Duration(milliseconds: 800),
    Duration pulseDuration = const Duration(milliseconds: 400),
  }) {
    // プログレスアニメーション（滑らかなイージング）
    _progressController = AnimationController(
      vsync: vsync,
      duration: progressDuration,
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic, // Cubic Bezier イージング
    );

    // パルスアニメーション（タスク完了時）
    _pulseController = AnimationController(
      vsync: vsync,
      duration: pulseDuration,
    );

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.15,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.15,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_pulseController);
  }

  /// 現在のプログレス値（アニメーション適用後）
  Animation<double> get progressAnimation => _progressAnimation;

  /// パルスアニメーション（スケール値）
  Animation<double> get pulseAnimation => _pulseAnimation;

  /// プログレスコントローラー
  AnimationController get progressController => _progressController;

  /// パルスコントローラー
  AnimationController get pulseController => _pulseController;

  /// 現在の実際のプログレス値
  double get currentProgress => _currentProgress;

  /// ターゲットプログレス値
  double get targetProgress => _targetProgress;

  /// プログレスを更新（アニメーション付き）
  Future<void> animateToProgress(
    double progress, {
    bool withPulse = false,
  }) async {
    _targetProgress = progress.clamp(0.0, 1.0);

    if (withPulse) {
      // パルスアニメーションを再生
      _pulseController.forward(from: 0.0);
    }

    // プログレスアニメーションを実行
    await _progressController.forward(from: 0.0);
    _currentProgress = _targetProgress;
  }

  /// プログレスを即座に設定（アニメーションなし）
  void setProgress(double progress) {
    _currentProgress = progress.clamp(0.0, 1.0);
    _targetProgress = _currentProgress;
    _progressController.value = 1.0;
  }

  /// パルスアニメーションのみを再生
  Future<void> playPulse() async {
    await _pulseController.forward(from: 0.0);
  }

  /// 計算されたプログレス値を取得
  double getAnimatedProgress() {
    final animationValue = _progressAnimation.value;
    return _currentProgress +
        (_targetProgress - _currentProgress) * animationValue;
  }

  /// リソースを解放
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
  }
}
