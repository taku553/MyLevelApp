import 'package:web/web.dart' as web;

/// Web版: 初期化がハングした際にブラウザのページ自体をリロードする
/// (Dartレイヤーでの再試行だけでは、JS SDK側で固まったPromiseなどが復旧しないため確実性を優先)
void reloadApp() {
  web.window.location.reload();
}
