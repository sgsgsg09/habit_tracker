// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HabitAttempt {
// 습관 시도 날짜
  DateTime get date; // 시도 결과: true면 성공, false면 실패
  bool get isSuccess;

  /// Create a copy of HabitAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HabitAttemptCopyWith<HabitAttempt> get copyWith =>
      _$HabitAttemptCopyWithImpl<HabitAttempt>(
          this as HabitAttempt, _$identity);

  /// Serializes this HabitAttempt to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HabitAttempt &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, isSuccess);

  @override
  String toString() {
    return 'HabitAttempt(date: $date, isSuccess: $isSuccess)';
  }
}

/// @nodoc
abstract mixin class $HabitAttemptCopyWith<$Res> {
  factory $HabitAttemptCopyWith(
          HabitAttempt value, $Res Function(HabitAttempt) _then) =
      _$HabitAttemptCopyWithImpl;
  @useResult
  $Res call({DateTime date, bool isSuccess});
}

/// @nodoc
class _$HabitAttemptCopyWithImpl<$Res> implements $HabitAttemptCopyWith<$Res> {
  _$HabitAttemptCopyWithImpl(this._self, this._then);

  final HabitAttempt _self;
  final $Res Function(HabitAttempt) _then;

  /// Create a copy of HabitAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? isSuccess = null,
  }) {
    return _then(_self.copyWith(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HabitAttempt implements HabitAttempt {
  const _HabitAttempt({required this.date, required this.isSuccess});
  factory _HabitAttempt.fromJson(Map<String, dynamic> json) =>
      _$HabitAttemptFromJson(json);

// 습관 시도 날짜
  @override
  final DateTime date;
// 시도 결과: true면 성공, false면 실패
  @override
  final bool isSuccess;

  /// Create a copy of HabitAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HabitAttemptCopyWith<_HabitAttempt> get copyWith =>
      __$HabitAttemptCopyWithImpl<_HabitAttempt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HabitAttemptToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HabitAttempt &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, isSuccess);

  @override
  String toString() {
    return 'HabitAttempt(date: $date, isSuccess: $isSuccess)';
  }
}

/// @nodoc
abstract mixin class _$HabitAttemptCopyWith<$Res>
    implements $HabitAttemptCopyWith<$Res> {
  factory _$HabitAttemptCopyWith(
          _HabitAttempt value, $Res Function(_HabitAttempt) _then) =
      __$HabitAttemptCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime date, bool isSuccess});
}

/// @nodoc
class __$HabitAttemptCopyWithImpl<$Res>
    implements _$HabitAttemptCopyWith<$Res> {
  __$HabitAttemptCopyWithImpl(this._self, this._then);

  final _HabitAttempt _self;
  final $Res Function(_HabitAttempt) _then;

  /// Create a copy of HabitAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = null,
    Object? isSuccess = null,
  }) {
    return _then(_HabitAttempt(
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSuccess: null == isSuccess
          ? _self.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
