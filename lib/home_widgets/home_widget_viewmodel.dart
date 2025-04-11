// home_widget_viewmodel.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_tracker/habits/models/habit_model.dart';
import 'package:habits_tracker/habits/viewmodels/habit_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_widget_viewmodel.g.dart';

@riverpod
class HomeWidgetNotifier extends _$HomeWidgetNotifier {
  // Flutter -> Android 위젯 통신용 MethodChannel
  static const platform =
      MethodChannel('com.example.habits_tracker/update_widget');

  // Android 위젯 -> Flutter 통신용 MethodChannel
  static const widgetActionChannel =
      MethodChannel('com.example.habits_tracker/widget_action');

  @override
  Future<List<HabitModel>> build() async {
    // 위젯 액션 리스너 설정
    _setupWidgetActionListener();

    // 습관 데이터 가져오기
    final habits =
        await ref.watch(habitViewModelProvider.notifier).getHabitsForToday();

    if (habits.isNotEmpty) {
      // 전체 습관 정보를 SharedPreferences에 저장 후, 위젯 갱신
      await _updateAndroidWidget(habits);
    }

    return habits;
  }

  // 위젯에서 받은 액션을 처리하는 리스너
  void _setupWidgetActionListener() {
    widgetActionChannel.setMethodCallHandler((call) async {
      if (call.method == 'incrementHabit') {
        final Map<dynamic, dynamic> data = call.arguments;
        final String habitTitle = data['title'];

        print('Widget action received: incrementHabit for $habitTitle');

        // 제목으로 습관 찾기
        final habits =
            await ref.read(habitViewModelProvider.notifier).getHabitsForToday();
        final habitIndex = habits.indexWhere((h) => h.title == habitTitle);

        if (habitIndex != -1) {
          final habit = habits[habitIndex];

          // 이미 목표에 도달했으면 아무것도 하지 않음
          if (habit.currentCount >= habit.targetCount) {
            return false;
          }

          // 습관 카운트 증가를 위해 updateHabit 사용
          final updatedHabit =
              habit.copyWith(currentCount: habit.currentCount + 1);

          await ref
              .read(habitViewModelProvider.notifier)
              .updateHabit(updatedHabit);

          // 위젯 데이터 업데이트
          final updatedHabits = await ref
              .read(habitViewModelProvider.notifier)
              .getHabitsForToday();
          await _updateAndroidWidget(updatedHabits);

          // 상태 갱신
          state = AsyncData(updatedHabits);

          return true;
        }
      }
      return false;
    });
  }

  // Android 홈 위젯 업데이트
  Future<void> _updateAndroidWidget(List<HabitModel> habits) async {
    try {
      // 가져온 HabitModel 리스트에서 필요한 필드만 골라 Map으로 만든 뒤, JSON으로 변환
      final habitMaps = habits.map((habit) {
        return {
          'title': habit.title,
          'targetCount': habit.targetCount,
          'currentCount': habit.currentCount,
          'colorHex': habit.colorHex ?? '#FFFFFF',
          'id': habit.id,
        };
      }).toList();

      final jsonString = jsonEncode(habitMaps);
      print('Saving widget data: $jsonString');

      // SharedPreferences에 저장
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

  // 수동으로 위젯 데이터를 새로고침
  Future<void> refreshWidgetData() async {
    final habits =
        await ref.read(habitViewModelProvider.notifier).getHabitsForToday();
    await _updateAndroidWidget(habits);
    state = AsyncData(habits);
  }
}
