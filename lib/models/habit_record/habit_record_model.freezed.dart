// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HabitRecordModel {
// 해당 습관의 고유 ID
  String get habitId; // 습관 시도 기록들의 리스트
  List<HabitAttempt> get attempts;

  /// Create a copy of HabitRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HabitRecordModelCopyWith<HabitRecordModel> get copyWith =>
      _$HabitRecordModelCopyWithImpl<HabitRecordModel>(
          this as HabitRecordModel, _$identity);

  /// Serializes this HabitRecordModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HabitRecordModel &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            const DeepCollectionEquality().equals(other.attempts, attempts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, habitId, const DeepCollectionEquality().hash(attempts));

  @override
  String toString() {
    return 'HabitRecordModel(habitId: $habitId, attempts: $attempts)';
  }
}

/// @nodoc
abstract mixin class $HabitRecordModelCopyWith<$Res> {
  factory $HabitRecordModelCopyWith(
          HabitRecordModel value, $Res Function(HabitRecordModel) _then) =
      _$HabitRecordModelCopyWithImpl;
  @useResult
  $Res call({String habitId, List<HabitAttempt> attempts});
}

/// @nodoc
class _$HabitRecordModelCopyWithImpl<$Res>
    implements $HabitRecordModelCopyWith<$Res> {
  _$HabitRecordModelCopyWithImpl(this._self, this._then);

  final HabitRecordModel _self;
  final $Res Function(HabitRecordModel) _then;

  /// Create a copy of HabitRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? habitId = null,
    Object? attempts = null,
  }) {
    return _then(_self.copyWith(
      habitId: null == habitId
          ? _self.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String,
      attempts: null == attempts
          ? _self.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<HabitAttempt>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HabitRecordModel implements HabitRecordModel {
  const _HabitRecordModel(
      {required this.habitId, final List<HabitAttempt> attempts = const []})
      : _attempts = attempts;
  factory _HabitRecordModel.fromJson(Map<String, dynamic> json) =>
      _$HabitRecordModelFromJson(json);

// 해당 습관의 고유 ID
  @override
  final String habitId;
// 습관 시도 기록들의 리스트
  final List<HabitAttempt> _attempts;
// 습관 시도 기록들의 리스트
  @override
  @JsonKey()
  List<HabitAttempt> get attempts {
    if (_attempts is EqualUnmodifiableListView) return _attempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attempts);
  }

  /// Create a copy of HabitRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HabitRecordModelCopyWith<_HabitRecordModel> get copyWith =>
      __$HabitRecordModelCopyWithImpl<_HabitRecordModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HabitRecordModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HabitRecordModel &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            const DeepCollectionEquality().equals(other._attempts, _attempts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, habitId, const DeepCollectionEquality().hash(_attempts));

  @override
  String toString() {
    return 'HabitRecordModel(habitId: $habitId, attempts: $attempts)';
  }
}

/// @nodoc
abstract mixin class _$HabitRecordModelCopyWith<$Res>
    implements $HabitRecordModelCopyWith<$Res> {
  factory _$HabitRecordModelCopyWith(
          _HabitRecordModel value, $Res Function(_HabitRecordModel) _then) =
      __$HabitRecordModelCopyWithImpl;
  @override
  @useResult
  $Res call({String habitId, List<HabitAttempt> attempts});
}

/// @nodoc
class __$HabitRecordModelCopyWithImpl<$Res>
    implements _$HabitRecordModelCopyWith<$Res> {
  __$HabitRecordModelCopyWithImpl(this._self, this._then);

  final _HabitRecordModel _self;
  final $Res Function(_HabitRecordModel) _then;

  /// Create a copy of HabitRecordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? habitId = null,
    Object? attempts = null,
  }) {
    return _then(_HabitRecordModel(
      habitId: null == habitId
          ? _self.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String,
      attempts: null == attempts
          ? _self._attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as List<HabitAttempt>,
    ));
  }
}

// dart format on
