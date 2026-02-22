import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'task.dart';

part 'mission.freezed.dart';
part 'mission.g.dart';

@freezed
class Mission with _$Mission {
  @HiveType(typeId: 1)
  const factory Mission({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) @Default([]) List<Task> tasks,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) DateTime? completedAt,
    @HiveField(5) int? levelBeforeCompletion,
    @HiveField(6) int? levelAfterCompletion,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);
}
