import 'package:freezed_annotation/freezed_annotation.dart';
import 'habit_attempt.dart';

part 'habit_record_model.freezed.dart';
part 'habit_record_model.g.dart';

@freezed
abstract class HabitRecordModel with _$HabitRecordModel {
  const factory HabitRecordModel({
    // 해당 습관의 고유 ID
    required String habitId,
    // 습관 시도 기록들의 리스트
    @Default([]) List<HabitAttempt> attempts,
  }) = _HabitRecordModel;

  factory HabitRecordModel.fromJson(Map<String, dynamic> json) =>
      _$HabitRecordModelFromJson(json);
}
