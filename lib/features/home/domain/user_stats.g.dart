// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStatsImplAdapter extends TypeAdapter<_$UserStatsImpl> {
  @override
  final int typeId = 2;

  @override
  _$UserStatsImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$UserStatsImpl(
      level: fields[0] as int,
      currentExp: fields[1] as int,
      nextLevelExp: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$UserStatsImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.currentExp)
      ..writeByte(2)
      ..write(obj.nextLevelExp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      level: (json['level'] as num?)?.toInt() ?? 1,
      currentExp: (json['currentExp'] as num?)?.toInt() ?? 0,
      nextLevelExp: (json['nextLevelExp'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'currentExp': instance.currentExp,
      'nextLevelExp': instance.nextLevelExp,
    };
