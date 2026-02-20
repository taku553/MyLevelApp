import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/router/app_router.dart';
import 'features/mission/domain/task.dart';
import 'features/mission/domain/mission.dart';
import 'features/home/domain/user_stats.dart';
import 'features/mission/data/mission_repository.dart';
import 'features/home/data/user_stats_repository.dart';

void main() async {
  // Flutterエンジンの初期化
  WidgetsFlutterBinding.ensureInitialized();

  // Hive (ローカルDB) の初期化
  await Hive.initFlutter();

  // Hive Adapterの登録
  Hive.registerAdapter(TaskImplAdapter()); // typeId: 0
  Hive.registerAdapter(MissionImplAdapter()); // typeId: 1
  Hive.registerAdapter(UserStatsImplAdapter()); // typeId: 2

  debugPrint('🚀 main: Creating repository instances...');
  // Repositoryの初期化
  final missionRepo = MissionRepository();
  final userStatsRepo = UserStatsRepository();
  debugPrint('🚀 main: MissionRepository instance: ${missionRepo.hashCode}');
  debugPrint(
    '🚀 main: UserStatsRepository instance: ${userStatsRepo.hashCode}',
  );
  debugPrint('🚀 main: Initializing repositories...');
  await missionRepo.init();
  await userStatsRepo.init();
  debugPrint('🚀 main: Repositories initialized successfully');

  // デバッグ用：コンフェッティテスト用にレベル9から開始
  // TODO: テスト完了後はこのコードを削除すること
  if (kDebugMode) {
    debugPrint('🎮 DEBUG: Setting level to 9 for confetti testing');
    const testStats = UserStats(level: 9, currentExp: 0, nextLevelExp: 500);
    await userStatsRepo.saveStats(testStats);
  }

  // 日付フォーマットの日本語化
  await initializeDateFormatting('ja_JP');

  runApp(
    ProviderScope(
      overrides: [
        missionRepositoryProvider.overrideWithValue(missionRepo),
        userStatsRepositoryProvider.overrideWithValue(userStatsRepo),
      ],
      child: const MissionLevelerApp(),
    ),
  );
}

class MissionLevelerApp extends ConsumerStatefulWidget {
  const MissionLevelerApp({super.key});

  @override
  ConsumerState<MissionLevelerApp> createState() => _MissionLevelerAppState();
}

class _MissionLevelerAppState extends ConsumerState<MissionLevelerApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // GoRouterは一度だけ取得してキャッシュする。
    // ref.watchで毎回buildが走るとGoRouterが再生成され、
    // AndroidのバックナビゲーションコールバックがProvider内のdisposeで
    // 適切に管理されるようになる。
    _router = ref.read(appRouterProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mission Leveler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF87171), // モックアップのアクセントカラー
          primary: const Color(0xFFF87171),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.notoSansJpTextTheme(), // プロジェクト全体のデフォルトフォント
      ),
      routerConfig: _router,
    );
  }
}
