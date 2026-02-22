import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/mission.dart';

class MissionRepository {
  static const String _boxName = 'missions';
  Box<Mission>? _box;

  MissionRepository() {
    debugPrint(
      '🏗️ MissionRepository: Constructor called (instance: $hashCode)',
    );
  }

  // Boxの初期化
  Future<void> init() async {
    debugPrint('🔧 MissionRepository: Initializing... (instance: $hashCode)');
    _box = await Hive.openBox<Mission>(_boxName);
    debugPrint(
      '🔧 MissionRepository: Initialized. Box has ${_box?.length ?? 0} missions',
    );
  }

  // 全ミッション取得
  List<Mission> getAllMissions() {
    return _box?.values.toList() ?? [];
  }

  // アクティブなミッション取得（未完了のみ）
  List<Mission> getActiveMissions() {
    debugPrint('📖 MissionRepository: _box is null? ${_box == null}');
    debugPrint(
      '📖 MissionRepository: Reading missions from box (total: ${_box?.length ?? 0})',
    );
    if (_box != null) {
      debugPrint('📖 MissionRepository: Box keys: ${_box!.keys.toList()}');
    }
    final missions =
        _box?.values.where((mission) => mission.completedAt == null).toList() ??
        [];
    debugPrint(
      '📖 MissionRepository: Found ${missions.length} active missions',
    );
    return missions;
  }

  // 完了済みミッション取得（新しい順）
  List<Mission> getCompletedMissions() {
    final missions =
        _box?.values.where((mission) => mission.completedAt != null).toList() ??
        [];
    missions.sort((a, b) => b.completedAt!.compareTo(a.completedAt!));
    return missions;
  }

  // ミッション追加
  Future<void> addMission(Mission mission) async {
    debugPrint(
      '💾 MissionRepository: Saving mission "${mission.title}" (ID: ${mission.id})',
    );
    debugPrint('💾 MissionRepository: _box is null? ${_box == null}');
    if (_box == null) {
      debugPrint('❌ MissionRepository: Box is null! Reinitializing...');
      await init();
    }
    await _box?.put(mission.id, mission);
    debugPrint(
      '💾 MissionRepository: Box now has ${_box?.length ?? 0} missions',
    );
    // 保存確認
    final saved = _box?.get(mission.id);
    debugPrint(
      '💾 MissionRepository: Verification - Mission saved? ${saved != null}',
    );
  }

  // ミッション更新
  Future<void> updateMission(Mission mission) async {
    await _box?.put(mission.id, mission);
  }

  // ミッション削除
  Future<void> deleteMission(String id) async {
    await _box?.delete(id);
  }

  // 特定のミッション取得
  Mission? getMissionById(String id) {
    return _box?.get(id);
  }
}

// Riverpod Provider
final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepository();
});
