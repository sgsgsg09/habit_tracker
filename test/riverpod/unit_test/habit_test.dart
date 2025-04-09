// test/habit_view_model_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:slow_food/models/habit_model.dart';
import 'package:slow_food/services/abstract_habit_repository.dart';
import 'package:slow_food/services/provider_habit_repository.dart';
import 'package:slow_food/viewmodels/habit_view_model.dart';

/// 실제 프로젝트의 HabitRepository 인터페이스에 맞춘 FakeHabitRepository 구현
class FakeHabitRepository implements HabitRepository {
  // 메모리 내에서 습관 데이터를 관리합니다.
  final List<HabitModel> habits = [];

  @override
  Future<List<HabitModel>> fetchHabits() async {
    // 딜레이 없이 단순히 데이터를 반환합니다.
    return habits;
  }

  @override
  Future<void> addHabit(HabitModel habit) async {
    habits.add(habit);
  }

  @override
  Future<void> deleteHabit(String id) async {
    habits.removeWhere((habit) => habit.id == id);
  }

  @override
  Future<void> updateHabit(HabitModel habit) async {
    final index = habits.indexWhere((h) => h.id == habit.id);
    if (index != -1) {
      habits[index] = habit;
    }
  }

  @override
  Future<HabitModel?> getHabit(String id) async {
    try {
      return habits.firstWhere((habit) => habit.id == id);
    } catch (e) {
      return null;
    }
  }
}

void main() {
  group('HabitViewModel Tests', () {
    late FakeHabitRepository fakeRepository;
    late ProviderContainer container;

    setUp(() {
      // Fake repository 인스턴스를 생성
      fakeRepository = FakeHabitRepository();
      // habitViewModelProvider가 내부적으로 의존하는 providerHabitRepository를 오버라이드합니다.
      container = ProviderContainer(
        overrides: [
          providerHabitRepository.overrideWithValue(fakeRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('build() 시 repository 데이터가 초기 상태로 읽혀야 함', () async {
      // 테스트용 샘플 습관 생성 (title 포함)
      final sampleHabit = HabitModel(
        id: 'habit1',
        title: '물 10잔 마시기',
        frequency: [1, 2, 3],
        targetCount: 5,
        // 나머지는 기본값 사용 (currentCount: 0, isActive: true 등)
        iconName: 'icon1',
        colorHex: '#FF0000',
      );
      fakeRepository.habits.add(sampleHabit);

      // provider의 future를 읽으면 HabitViewModel이 repository 데이터를 불러옵니다.
      final habits = await container.read(habitViewModelProvider.future);
      expect(habits, [sampleHabit]);
    });

    test('refreshHabits()가 상태를 업데이트해야 함', () async {
      // 초기 데이터: 하나의 습관
      final habit1 = HabitModel(
        id: 'habit1',
        title: '운동',
        frequency: [1, 2, 3],
        targetCount: 5,
        iconName: 'icon1',
        colorHex: '#FF0000',
      );
      fakeRepository.habits.add(habit1);

      // 초기 상태 검증
      var habits = await container.read(habitViewModelProvider.future);
      expect(habits, [habit1]);

      // repository에 새로운 습관 추가
      final habit2 = HabitModel(
        id: 'habit2',
        title: '독서',
        frequency: [4, 5, 6],
        targetCount: 10,
        iconName: 'icon2',
        colorHex: '#00FF00',
      );
      fakeRepository.habits.add(habit2);

      // refresh 호출 후 상태 업데이트 검증
      await container.read(habitViewModelProvider.notifier).refreshHabits();
      habits = await container.read(habitViewModelProvider.future);
      expect(habits, [habit1, habit2]);
    });

    test('addHabit()가 새 습관을 추가해야 함', () async {
      final notifier = container.read(habitViewModelProvider.notifier);
      final newHabit = HabitModel(
        id: 'habit1',
        title: '명상',
        frequency: [1, 2],
        targetCount: 7,
        iconName: 'icon3',
        colorHex: '#123456',
      );
      await notifier.addHabit(newHabit);

      final habits = await container.read(habitViewModelProvider.future);
      expect(habits.contains(newHabit), true);
    });

    test('deleteHabit()가 습관을 삭제해야 함', () async {
      final habit = HabitModel(
        id: 'habit1',
        title: '일기 쓰기',
        frequency: [1, 2],
        targetCount: 5,
        iconName: 'icon1',
        colorHex: '#FF0000',
      );
      fakeRepository.habits.add(habit);

      // 초기 refresh 호출
      await container.read(habitViewModelProvider.notifier).refreshHabits();
      expect(fakeRepository.habits.length, 1);

      // 습관 삭제 수행
      await container
          .read(habitViewModelProvider.notifier)
          .deleteHabit('habit1');
      await container.read(habitViewModelProvider.notifier).refreshHabits();
      expect(fakeRepository.habits.length, 0);
    });

    test('updateHabit()가 습관을 수정해야 함', () async {
      final habit = HabitModel(
        id: 'habit1',
        title: '달리기',
        frequency: [1, 2],
        targetCount: 5,
        iconName: 'icon1',
        colorHex: '#FF0000',
      );
      fakeRepository.habits.add(habit);
      await container.read(habitViewModelProvider.notifier).refreshHabits();

      // 수정된 습관 데이터 (title은 그대로 두거나 변경 가능)
      final updatedHabit = HabitModel(
        id: 'habit1',
        title: '달리기', // 혹은 '조깅' 등으로 수정할 수 있음
        frequency: [1, 2],
        targetCount: 8, // 수정된 targetCount
        iconName: 'icon1',
        colorHex: '#00FF00',
      );
      await container
          .read(habitViewModelProvider.notifier)
          .updateHabit(updatedHabit);

      final habits = await container.read(habitViewModelProvider.future);
      expect(habits.first.targetCount, 8);
      expect(habits.first.colorHex, '#00FF00');
    });

    test('getHabit()이 id로 습관을 올바르게 조회해야 함', () async {
      final habit = HabitModel(
        id: 'habit1',
        title: '공부',
        frequency: [1, 2],
        targetCount: 5,
        iconName: 'icon1',
        colorHex: '#FF0000',
      );
      fakeRepository.habits.add(habit);

      final result = await container
          .read(habitViewModelProvider.notifier)
          .getHabit('habit1');
      expect(result, isNotNull);
      expect(result!.id, 'habit1');
      expect(result.title, '공부');
    });
  });
}
