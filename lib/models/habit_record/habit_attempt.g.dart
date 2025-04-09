// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HabitAttempt _$HabitAttemptFromJson(Map<String, dynamic> json) =>
    _HabitAttempt(
      date: DateTime.parse(json['date'] as String),
      isSuccess: json['isSuccess'] as bool,
    );

Map<String, dynamic> _$HabitAttemptToJson(_HabitAttempt instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'isSuccess': instance.isSuccess,
    };
