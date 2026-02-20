import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
class UserStats with _$UserStats {
  @HiveType(typeId: 2)
  const factory UserStats({
    @HiveField(0) @Default(1) int level,
    @HiveField(1) @Default(0) int currentExp,
    @HiveField(2)
    @Default(100)
    int nextLevelExp, // 次のレベルに必要なトータル経験値ではなく、そのレベルで必要な経験値を想定
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}
