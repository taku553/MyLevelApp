import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'animation_coordinator.dart';

/// AnimationCoordinatorのProvider
/// アプリ全体で単一のインスタンスを共有
final animationCoordinatorProvider = Provider<AnimationCoordinator>((ref) {
  return AnimationCoordinator();
});
