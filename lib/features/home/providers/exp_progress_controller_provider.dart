import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/animations/progress_animation_controller.dart';

/// ExpProgressWidgetのProgressAnimationControllerを管理するProvider
/// タスク完了時にアニメーション完了を待つために使用
class ExpProgressControllerHolder {
  ProgressAnimationController? controller;

  Future<void> animateToProgressAndWait(
    double progress, {
    bool withPulse = false,
  }) async {
    if (controller != null) {
      await controller!.animateToProgress(progress, withPulse: withPulse);
    } else {
      // コントローラーが存在しない場合（ExpProgressWidget が dispose されている等）
      // プログレスバーのアニメーション時間相当の待機を行う
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

  void setProgress(double progress) {
    controller?.setProgress(progress);
  }

  double getAnimatedProgress() {
    return controller?.getAnimatedProgress() ?? 0.0;
  }
}

final expProgressControllerProvider = Provider<ExpProgressControllerHolder>((
  ref,
) {
  return ExpProgressControllerHolder();
});
