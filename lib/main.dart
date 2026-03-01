import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/auth/auth_service.dart';
import 'core/auth/login_screen.dart';

import 'core/router/app_router.dart';
import 'features/mission/domain/task.dart';
import 'features/mission/domain/mission.dart';
import 'features/home/domain/user_stats.dart';
import 'features/mission/data/mission_repository.dart';
import 'features/home/data/user_stats_repository.dart';

void main() async {
  // Flutterエンジンの初期化
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseの初期化
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hive (ローカルDB) の初期化
  await Hive.initFlutter();

  // Hive Adapterの登録
  Hive.registerAdapter(TaskImplAdapter()); // typeId: 0
  Hive.registerAdapter(MissionImplAdapter()); // typeId: 1
  Hive.registerAdapter(UserStatsImplAdapter()); // typeId: 2

  // 日付フォーマットの日本語化
  await initializeDateFormatting('ja_JP');

  runApp(const ProviderScope(child: MissionLevelerApp()));
}

class MissionLevelerApp extends ConsumerWidget {
  const MissionLevelerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Mission Leveler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF87171),
          primary: const Color(0xFFF87171),
        ),
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
      ),
      home: authState.when(
        data: (user) {
          if (user == null) {
            // 未ログイン → ログイン画面
            return const LoginScreen();
          }
          // ログイン済み → メインアプリ（UID付きでRepository初期化）
          return _AuthenticatedApp(uid: user.uid);
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (_, __) => const LoginScreen(),
      ),
    );
  }
}

/// ログイン後のメインアプリ
/// UIDが確定してからRepositoryを初期化し、GoRouterで画面遷移する
class _AuthenticatedApp extends ConsumerStatefulWidget {
  final String uid;
  const _AuthenticatedApp({required this.uid});

  @override
  ConsumerState<_AuthenticatedApp> createState() => _AuthenticatedAppState();
}

class _AuthenticatedAppState extends ConsumerState<_AuthenticatedApp> {
  late final GoRouter _router;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initRepositories();
  }

  Future<void> _initRepositories() async {
    debugPrint('🚀 App: Initializing repositories for uid=${widget.uid}');

    final missionRepo = MissionRepository(uid: widget.uid);
    final userStatsRepo = UserStatsRepository(uid: widget.uid);

    await missionRepo.init();
    await userStatsRepo.init();

    debugPrint('🚀 App: Repositories initialized successfully');

    // デバッグ用：起動時のステータス操作フラグ
    const bool resetStats = bool.fromEnvironment(
      'RESET_STATS',
      defaultValue: false,
    );
    const bool forceLevel9 = bool.fromEnvironment(
      'FORCE_LEVEL_9',
      defaultValue: false,
    );
    if (resetStats) {
      debugPrint('🔄 DEBUG: Resetting stats to level 1');
      const initialStats = UserStats(
        level: 1,
        currentExp: 0,
        nextLevelExp: 100,
      );
      await userStatsRepo.saveStats(initialStats);
    } else if (forceLevel9) {
      debugPrint('🎮 DEBUG: Setting level to 9');
      const testStats = UserStats(level: 9, currentExp: 0, nextLevelExp: 500);
      await userStatsRepo.saveStats(testStats);
    }

    if (mounted) {
      // Providerを上書きしてからGoRouterを生成
      ref.read(missionRepositoryProvider.notifier).state = missionRepo;
      ref.read(userStatsRepositoryProvider.notifier).state = userStatsRepo;
      _router = ref.read(appRouterProvider);
      setState(() {
        _initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return MaterialApp.router(
      title: 'Mission Leveler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF87171),
          primary: const Color(0xFFF87171),
        ),
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
      ),
      routerConfig: _router,
    );
  }
}
