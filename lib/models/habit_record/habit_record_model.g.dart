// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HabitRecordModel _$HabitRecordModelFromJson(Map<String, dynamic> json) =>
    _HabitRecordModel(
      habitId: json['habitId'] as String,
      attempts: (json['attempts'] as List<dynamic>?)
              ?.map((e) => HabitAttempt.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HabitRecordModelToJson(_HabitRecordModel instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'attempts': instance.attempts,
    };
