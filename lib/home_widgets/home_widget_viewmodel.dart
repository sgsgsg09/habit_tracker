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
  // Android 홈 위젯과 통신할 MethodChannel 정의
  // MainActvity.kt에 선언된 CHANNEL 값과 정확히 일치해야 함
  const platform = MethodChannel('com.example.habits_tracker/update_widget');

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
    print('Saving widget data: $jsonString');

    // SharedPreferences에 저장
    // Android 코드가 'flutter.tasks'를 찾을 것이므로 'tasks'로 저장
    // Flutter가 자동으로 'flutter.' 접두사를 붙여 'flutter.tasks'로 저장함
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', jsonString);
    // 저장 후 바로 데이터를 다시 읽어 확인
    final savedData = prefs.getString('tasks');
    print('Saved data verification: $savedData');
    // Android 앱 위젯에 갱신 요청 보내기
    await platform.invokeMethod('updateWidget');
    print('Widget update requested via MethodChannel');
  } catch (e) {
    print('Error updating widget: $e');
  }
}
