// test/home_widget_viewmodel_test.dart

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habits_tracker/habits/models/habit_model.dart';
import 'package:habits_tracker/habits/viewmodels/habit_view_model.dart';
import 'package:habits_tracker/home_widgets/home_widget_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// HabitViewModel의 동작을 흉내내는 Fake를 정의합니다.
/// 이 Fake는 HabitViewModel을 상속하여 실제 구현체와 동일한 타입을 반환하도록 합니다.
class FakeHabitViewModelNotifier extends HabitViewModel {
  final List<HabitModel> fakeHabits;

  FakeHabitViewModelNotifier(this.fakeHabits);

  @override
  Future<List<HabitModel>> getHabitsForToday() async {
    // 단순히 fake 데이터 리턴
    return fakeHabits;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const String methodChannelName = 'com.example.habits_tracker/update_widget';

  late ProviderContainer container;

  setUp(() {
    // 테스트 전 SharedPreferences 초기화
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    container.dispose();
  });

  group('homeWidget provider 테스트', () {
    test('데이터가 존재하는 경우: SharedPreferences 업데이트 및 updateWidget 호출 확인', () async {
      bool methodChannelCalled = false;
      final MethodChannel channel = const MethodChannel(methodChannelName);
      channel.setMockMethodCallHandler((MethodCall call) async {
        if (call.method == 'updateWidget') {
          methodChannelCalled = true;
        }
        return null;
      });

      // 예시 HabitModel (id 'habit2', title '독서' 등)
      final sampleHabit = HabitModel(
        id: 'habit2',
        title: '독서',
        frequency: [4, 5, 6],
        targetCount: 10,
        currentCount: 0, // 기본값 0
        iconName: 'icon2',
        colorHex: '#00FF00',
      );

      // FakeHabitViewModelNotifier 인스턴스 생성 (데이터가 있는 경우)
      final fakeNotifier = FakeHabitViewModelNotifier([sampleHabit]);

      // habitViewModelProvider를 Fake로 오버라이드합니다.
      container = ProviderContainer(overrides: [
        habitViewModelProvider.overrideWith(() => fakeNotifier),
      ]);

      // homeWidget 프로바이더를 통해 습관 데이터를 읽어옵니다.
      final habits = await container.read(homeWidgetProvider.future);

      // 반환된 데이터 검증
      expect(habits, [sampleHabit]);

      // SharedPreferences에 저장된 JSON 문자열 검증
      final prefs = await SharedPreferences.getInstance();
      final storedJson = prefs.getString('tasks');
      expect(storedJson, isNotNull);
      final expectedMap = [
        {
          'title': sampleHabit.title,
          'targetCount': sampleHabit.targetCount,
          'currentCount': sampleHabit.currentCount,
          'colorHex': sampleHabit.colorHex,
        }
      ];
      expect(storedJson, jsonEncode(expectedMap));

      // MethodChannel의 updateWidget 호출 검증
      expect(methodChannelCalled, isTrue);

      channel.setMockMethodCallHandler(null);
    });

    test('데이터가 없는 경우: 빈 리스트 반환 및 업데이트 미발생', () async {
      bool methodChannelCalled = false;
      final MethodChannel channel = const MethodChannel(methodChannelName);
      channel.setMockMethodCallHandler((MethodCall call) async {
        if (call.method == 'updateWidget') {
          methodChannelCalled = true;
        }
        return null;
      });

      // 빈 리스트인 FakeHabitViewModelNotifier 생성
      final fakeNotifier = FakeHabitViewModelNotifier([]);
      container = ProviderContainer(overrides: [
        habitViewModelProvider.overrideWith(() => fakeNotifier),
      ]);

      final habits = await container.read(homeWidgetProvider.future);
      expect(habits, isEmpty);

      // SharedPreferences에 'tasks'가 저장되지 않았는지 검증
      final prefs = await SharedPreferences.getInstance();
      final storedJson = prefs.getString('tasks');
      expect(storedJson, isNull);

      // MethodChannel 호출 검증 (호출되지 않아야 함)
      expect(methodChannelCalled, isFalse);

      channel.setMockMethodCallHandler(null);
    });
  });
}
