import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../mission/providers/mission_provider.dart';
import '../providers/user_stats_provider.dart';
import '../widgets/exp_progress_widget.dart';
import '../widgets/mission_list_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStatsAsync = ref.watch(userStatsProvider);
    final missionsAsync = ref.watch(missionListProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        bottom: false,
        child: userStatsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              'エラーが発生しました: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
          data: (userStats) {
            // アクティブなミッションを取得
            final activeMission = missionsAsync.maybeWhen(
              data: (missions) => missions.isNotEmpty ? missions.first : null,
              orElse: () => null,
            );

            return CustomScrollView(
              slivers: [
                // ヘッダー部分（レベルと経験値）
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                    color: AppColors.backgroundWhite,
                    child: Column(
                      children: [
                        // ミッション名（円形プログレスバーの上）
                        if (activeMission != null) ...[
                          Text(
                            'MISSION',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            activeMission.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                        ],
                        // 経験値プログレスバー（レベルも含む）
                        ExpProgressWidget(
                          level: userStats.level,
                          currentExp: userStats.currentExp,
                          nextLevelExp: userStats.nextLevelExp,
                        ),
                      ],
                    ),
                  ),
                ),
                // タスクセクションヘッダー
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.backgroundSection,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'TASKS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ミッションリスト
                const MissionListWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
