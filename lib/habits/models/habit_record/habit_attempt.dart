import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_attempt.freezed.dart';
part 'habit_attempt.g.dart';

@freezed
abstract class HabitAttempt with _$HabitAttempt {
  const factory HabitAttempt({
    // 습관 시도 날짜
    required DateTime date,
    // 시도 결과: true면 성공, false면 실패
    required bool isSuccess,
  }) = _HabitAttempt;

  factory HabitAttempt.fromJson(Map<String, dynamic> json) =>
      _$HabitAttemptFromJson(json);
}
