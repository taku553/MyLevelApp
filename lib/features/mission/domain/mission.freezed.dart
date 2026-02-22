// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Mission _$MissionFromJson(Map<String, dynamic> json) {
  return _Mission.fromJson(json);
}

/// @nodoc
mixin _$Mission {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  List<Task> get tasks => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @HiveField(5)
  int? get levelBeforeCompletion => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get levelAfterCompletion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MissionCopyWith<Mission> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCopyWith<$Res> {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) then) =
      _$MissionCopyWithImpl<$Res, Mission>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String title,
    @HiveField(2) List<Task> tasks,
    @HiveField(3) DateTime createdAt,
    @HiveField(4) DateTime? completedAt,
    @HiveField(5) int? levelBeforeCompletion,
    @HiveField(6) int? levelAfterCompletion,
  });
}

/// @nodoc
class _$MissionCopyWithImpl<$Res, $Val extends Mission>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? tasks = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? levelBeforeCompletion = freezed,
    Object? levelAfterCompletion = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            tasks: null == tasks
                ? _value.tasks
                : tasks // ignore: cast_nullable_to_non_nullable
                      as List<Task>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            levelBeforeCompletion: freezed == levelBeforeCompletion
                ? _value.levelBeforeCompletion
                : levelBeforeCompletion // ignore: cast_nullable_to_non_nullable
                      as int?,
            levelAfterCompletion: freezed == levelAfterCompletion
                ? _value.levelAfterCompletion
                : levelAfterCompletion // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MissionImplCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$$MissionImplCopyWith(
    _$MissionImpl value,
    $Res Function(_$MissionImpl) then,
  ) = __$$MissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String title,
    @HiveField(2) List<Task> tasks,
    @HiveField(3) DateTime createdAt,
    @HiveField(4) DateTime? completedAt,
    @HiveField(5) int? levelBeforeCompletion,
    @HiveField(6) int? levelAfterCompletion,
  });
}

/// @nodoc
class __$$MissionImplCopyWithImpl<$Res>
    extends _$MissionCopyWithImpl<$Res, _$MissionImpl>
    implements _$$MissionImplCopyWith<$Res> {
  __$$MissionImplCopyWithImpl(
    _$MissionImpl _value,
    $Res Function(_$MissionImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? tasks = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? levelBeforeCompletion = freezed,
    Object? levelAfterCompletion = freezed,
  }) {
    return _then(
      _$MissionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        tasks: null == tasks
            ? _value._tasks
            : tasks // ignore: cast_nullable_to_non_nullable
                  as List<Task>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        levelBeforeCompletion: freezed == levelBeforeCompletion
            ? _value.levelBeforeCompletion
            : levelBeforeCompletion // ignore: cast_nullable_to_non_nullable
                  as int?,
        levelAfterCompletion: freezed == levelAfterCompletion
            ? _value.levelAfterCompletion
            : levelAfterCompletion // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1)
class _$MissionImpl implements _Mission {
  const _$MissionImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.title,
    @HiveField(2) final List<Task> tasks = const [],
    @HiveField(3) required this.createdAt,
    @HiveField(4) this.completedAt,
    @HiveField(5) this.levelBeforeCompletion,
    @HiveField(6) this.levelAfterCompletion,
  }) : _tasks = tasks;

  factory _$MissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  final List<Task> _tasks;
  @override
  @JsonKey()
  @HiveField(2)
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  @HiveField(3)
  final DateTime createdAt;
  @override
  @HiveField(4)
  final DateTime? completedAt;
  @override
  @HiveField(5)
  final int? levelBeforeCompletion;
  @override
  @HiveField(6)
  final int? levelAfterCompletion;

  @override
  String toString() {
    return 'Mission(id: $id, title: $title, tasks: $tasks, createdAt: $createdAt, completedAt: $completedAt, levelBeforeCompletion: $levelBeforeCompletion, levelAfterCompletion: $levelAfterCompletion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.levelBeforeCompletion, levelBeforeCompletion) ||
                other.levelBeforeCompletion == levelBeforeCompletion) &&
            (identical(other.levelAfterCompletion, levelAfterCompletion) ||
                other.levelAfterCompletion == levelAfterCompletion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    const DeepCollectionEquality().hash(_tasks),
    createdAt,
    completedAt,
    levelBeforeCompletion,
    levelAfterCompletion,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      __$$MissionImplCopyWithImpl<_$MissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionImplToJson(this);
  }
}

abstract class _Mission implements Mission {
  const factory _Mission({
    @HiveField(0) required final String id,
    @HiveField(1) required final String title,
    @HiveField(2) final List<Task> tasks,
    @HiveField(3) required final DateTime createdAt,
    @HiveField(4) final DateTime? completedAt,
    @HiveField(5) final int? levelBeforeCompletion,
    @HiveField(6) final int? levelAfterCompletion,
  }) = _$MissionImpl;

  factory _Mission.fromJson(Map<String, dynamic> json) = _$MissionImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  List<Task> get tasks;
  @override
  @HiveField(3)
  DateTime get createdAt;
  @override
  @HiveField(4)
  DateTime? get completedAt;
  @override
  @HiveField(5)
  int? get levelBeforeCompletion;
  @override
  @HiveField(6)
  int? get levelAfterCompletion;
  @override
  @JsonKey(ignore: true)
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
