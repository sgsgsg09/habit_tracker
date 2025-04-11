// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HabitModel {
// 습관 고유 ID
  String get id; // 예: "물 10잔 마시기", "복약", "운동" 등
  String get title; // 반복할 요일 리스트 (예: [1,2,3,4,5,6,7]는 매일, [6,7]은 주말 등)
  List<int> get frequency; // 사용자 맞춤 목표치 (e.g., 10잔, 5번, etc.)
  int get targetCount; // 현재까지 달성한 횟수
  int get currentCount;
  bool get isActive; // 새로 추가
  String? get iconName;
  String? get colorHex;
  bool get notificationEnabled;
  DateTime? get notificationTime;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HabitModelCopyWith<HabitModel> get copyWith =>
      _$HabitModelCopyWithImpl<HabitModel>(this as HabitModel, _$identity);

  /// Serializes this HabitModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HabitModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.frequency, frequency) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.currentCount, currentCount) ||
                other.currentCount == currentCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.notificationEnabled, notificationEnabled) ||
                other.notificationEnabled == notificationEnabled) &&
            (identical(other.notificationTime, notificationTime) ||
                other.notificationTime == notificationTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(frequency),
      targetCount,
      currentCount,
      isActive,
      iconName,
      colorHex,
      notificationEnabled,
      notificationTime);

  @override
  String toString() {
    return 'HabitModel(id: $id, title: $title, frequency: $frequency, targetCount: $targetCount, currentCount: $currentCount, isActive: $isActive, iconName: $iconName, colorHex: $colorHex, notificationEnabled: $notificationEnabled, notificationTime: $notificationTime)';
  }
}

/// @nodoc
abstract mixin class $HabitModelCopyWith<$Res> {
  factory $HabitModelCopyWith(
          HabitModel value, $Res Function(HabitModel) _then) =
      _$HabitModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      List<int> frequency,
      int targetCount,
      int currentCount,
      bool isActive,
      String? iconName,
      String? colorHex,
      bool notificationEnabled,
      DateTime? notificationTime});
}

/// @nodoc
class _$HabitModelCopyWithImpl<$Res> implements $HabitModelCopyWith<$Res> {
  _$HabitModelCopyWithImpl(this._self, this._then);

  final HabitModel _self;
  final $Res Function(HabitModel) _then;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? frequency = null,
    Object? targetCount = null,
    Object? currentCount = null,
    Object? isActive = null,
    Object? iconName = freezed,
    Object? colorHex = freezed,
    Object? notificationEnabled = null,
    Object? notificationTime = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as List<int>,
      targetCount: null == targetCount
          ? _self.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentCount: null == currentCount
          ? _self.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      iconName: freezed == iconName
          ? _self.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      colorHex: freezed == colorHex
          ? _self.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationEnabled: null == notificationEnabled
          ? _self.notificationEnabled
          : notificationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationTime: freezed == notificationTime
          ? _self.notificationTime
          : notificationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _HabitModel implements HabitModel {
  const _HabitModel(
      {required this.id,
      required this.title,
      required final List<int> frequency,
      required this.targetCount,
      this.currentCount = 0,
      this.isActive = true,
      this.iconName,
      this.colorHex,
      this.notificationEnabled = false,
      this.notificationTime})
      : _frequency = frequency;
  factory _HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);

// 습관 고유 ID
  @override
  final String id;
// 예: "물 10잔 마시기", "복약", "운동" 등
  @override
  final String title;
// 반복할 요일 리스트 (예: [1,2,3,4,5,6,7]는 매일, [6,7]은 주말 등)
  final List<int> _frequency;
// 반복할 요일 리스트 (예: [1,2,3,4,5,6,7]는 매일, [6,7]은 주말 등)
  @override
  List<int> get frequency {
    if (_frequency is EqualUnmodifiableListView) return _frequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_frequency);
  }

// 사용자 맞춤 목표치 (e.g., 10잔, 5번, etc.)
  @override
  final int targetCount;
// 현재까지 달성한 횟수
  @override
  @JsonKey()
  final int currentCount;
  @override
  @JsonKey()
  final bool isActive;
// 새로 추가
  @override
  final String? iconName;
  @override
  final String? colorHex;
  @override
  @JsonKey()
  final bool notificationEnabled;
  @override
  final DateTime? notificationTime;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HabitModelCopyWith<_HabitModel> get copyWith =>
      __$HabitModelCopyWithImpl<_HabitModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HabitModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HabitModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._frequency, _frequency) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.currentCount, currentCount) ||
                other.currentCount == currentCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.notificationEnabled, notificationEnabled) ||
                other.notificationEnabled == notificationEnabled) &&
            (identical(other.notificationTime, notificationTime) ||
                other.notificationTime == notificationTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_frequency),
      targetCount,
      currentCount,
      isActive,
      iconName,
      colorHex,
      notificationEnabled,
      notificationTime);

  @override
  String toString() {
    return 'HabitModel(id: $id, title: $title, frequency: $frequency, targetCount: $targetCount, currentCount: $currentCount, isActive: $isActive, iconName: $iconName, colorHex: $colorHex, notificationEnabled: $notificationEnabled, notificationTime: $notificationTime)';
  }
}

/// @nodoc
abstract mixin class _$HabitModelCopyWith<$Res>
    implements $HabitModelCopyWith<$Res> {
  factory _$HabitModelCopyWith(
          _HabitModel value, $Res Function(_HabitModel) _then) =
      __$HabitModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      List<int> frequency,
      int targetCount,
      int currentCount,
      bool isActive,
      String? iconName,
      String? colorHex,
      bool notificationEnabled,
      DateTime? notificationTime});
}

/// @nodoc
class __$HabitModelCopyWithImpl<$Res> implements _$HabitModelCopyWith<$Res> {
  __$HabitModelCopyWithImpl(this._self, this._then);

  final _HabitModel _self;
  final $Res Function(_HabitModel) _then;

  /// Create a copy of HabitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? frequency = null,
    Object? targetCount = null,
    Object? currentCount = null,
    Object? isActive = null,
    Object? iconName = freezed,
    Object? colorHex = freezed,
    Object? notificationEnabled = null,
    Object? notificationTime = freezed,
  }) {
    return _then(_HabitModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _self._frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as List<int>,
      targetCount: null == targetCount
          ? _self.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentCount: null == currentCount
          ? _self.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      iconName: freezed == iconName
          ? _self.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      colorHex: freezed == colorHex
          ? _self.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationEnabled: null == notificationEnabled
          ? _self.notificationEnabled
          : notificationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationTime: freezed == notificationTime
          ? _self.notificationTime
          : notificationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
