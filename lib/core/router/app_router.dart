import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/mission/presentation/mission_creation_screen.dart';
import '../../features/mission/presentation/mission_confirmation_screen.dart';
import '../../features/mission/presentation/mission_created_screen.dart';
import '../../features/mission/presentation/mission_edit_screen.dart';
import '../../features/mission/presentation/mission_history_screen.dart';
import '../../features/mission/presentation/missions_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/mission/domain/mission.dart';
import '../widgets/bottom_navigation_bar.dart';

// ナビゲーションバーのナビゲーションキー
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider((ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // ShellRoute: ボトムナビ付きのタブ画面
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/missions',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MissionsScreen()),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
      // フルスクリーンルート: ボトムナビなし、push/popで遷移
      GoRoute(
        path: '/mission/create',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MissionCreationScreen(),
      ),
      GoRoute(
        path: '/mission/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final mission = state.extra as Mission;
          return MissionEditScreen(mission: mission);
        },
      ),
      GoRoute(
        path: '/mission/confirm',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          return MissionConfirmationScreen(
            missionName: extras['missionName'] as String,
            tasks: extras['tasks'] as List<Map<String, dynamic>>,
          );
        },
      ),
      GoRoute(
        path: '/mission/created',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MissionCreatedScreen(),
      ),
      GoRoute(
        path: '/mission/history',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MissionHistoryScreen(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
