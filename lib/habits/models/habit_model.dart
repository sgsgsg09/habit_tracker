// models/habit_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_model.freezed.dart';

part 'habit_model.g.dart';

@freezed
abstract class HabitModel with _$HabitModel {
  const factory HabitModel({
    // 습관 고유 ID
    required String id,
    // 예: "물 10잔 마시기", "복약", "운동" 등
    required String title,
    // 반복할 요일 리스트 (예: [1,2,3,4,5,6,7]는 매일, [6,7]은 주말 등)
    required List<int> frequency,
    // 사용자 맞춤 목표치 (e.g., 10잔, 5번, etc.)
    required int targetCount,
    // 현재까지 달성한 횟수
    @Default(0) int currentCount,
    @Default(true) bool isActive,

    // 새로 추가
    String? iconName,
    String? colorHex,
    @Default(false) bool notificationEnabled,
    DateTime? notificationTime,
  }) = _HabitModel;

  factory HabitModel.fromJson(Map<String, dynamic> json) =>
      _$HabitModelFromJson(json);
}
