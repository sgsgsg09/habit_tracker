// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HabitModel _$HabitModelFromJson(Map<String, dynamic> json) => _HabitModel(
      id: json['id'] as String,
      title: json['title'] as String,
      frequency: (json['frequency'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      targetCount: (json['targetCount'] as num).toInt(),
      currentCount: (json['currentCount'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      iconName: json['iconName'] as String?,
      colorHex: json['colorHex'] as String?,
      notificationEnabled: json['notificationEnabled'] as bool? ?? false,
      notificationTime: json['notificationTime'] == null
          ? null
          : DateTime.parse(json['notificationTime'] as String),
    );

Map<String, dynamic> _$HabitModelToJson(_HabitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'frequency': instance.frequency,
      'targetCount': instance.targetCount,
      'currentCount': instance.currentCount,
      'isActive': instance.isActive,
      'iconName': instance.iconName,
      'colorHex': instance.colorHex,
      'notificationEnabled': instance.notificationEnabled,
      'notificationTime': instance.notificationTime?.toIso8601String(),
    };
