import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_tracker/habits/models/habit_model.dart';
import 'package:habits_tracker/habits/viewmodels/habit_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// g.dart 파일 생성
part 'home_widget_viewmodel.g.dart';

@riverpod
Future<List<HabitModel>> homeWidget(Ref ref) async {
  // 1. habitViewModelProvider에서 데이터를 watch한다.
  final habitState =
      await ref.watch(habitViewModelProvider.notifier).getHabitsForToday();

  // 2. 만약 데이터가 로드되었다면, 전체 습관 리스트를 사용

  if (habitState.isNotEmpty) {
    // 전체 습관 정보를 SharedPreferences에 저장 후, 위젯 갱신
    await _updateAndroidWidget(habitState);

    // List<HabitModel> 반환
    return habitState;
  }

  // 빈 리스트 반환 (혹은 다른 예외 처리 로직)
  return [];
}

// _updateAndroidWidget이 전체 습관 리스트를 받아 처리하도록 수정
Future<void> _updateAndroidWidget(List<HabitModel> habits) async {
  const platform = MethodChannel('com.example.widgetnoteapp/update_widget');

  try {
    // 가져온 HabitModel 리스트에서 필요한 필드만 골라 Map으로 만든 뒤, JSON으로 변환
    final habitMaps = habits.map((habit) {
      return {
        'title': habit.title,
        'targetCount': habit.targetCount,
        'currentCount': habit.currentCount,
        'colorHex': habit.colorHex,
      };
    }).toList();

    final jsonString = jsonEncode(habitMaps);

    // SharedPreferences에 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', jsonString);

    // 안드로이드 위젯에 갱신 요청
    await platform.invokeMethod('updateWidget');
  } catch (e) {
    print('Error updating widget: $e');
  }
}
