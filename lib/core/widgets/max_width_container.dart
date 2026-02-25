import 'dart:math';
import 'package:flutter/material.dart';

/// コンテンツの最大幅を制限して中央寄せするコンテナ。
/// ウェブ表示でコンテンツが画面幅いっぱいに広がるのを防ぐ。
/// 親から受け取った高さ制約はそのまま子に引き継ぐため、
/// スクロールビューやナビゲーションバーのレイアウトを崩さない。
class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = 600,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 0,
              maxWidth: min(maxWidth, constraints.maxWidth),
              minHeight: constraints.minHeight,
              maxHeight: constraints.maxHeight,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
