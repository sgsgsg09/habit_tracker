// habit_view_model.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slow_food/models/habit_model.dart';
import 'package:slow_food/services/provider_habit_repository.dart';

part 'habit_view_model.g.dart';

/// Riverpod의 @riverpod 어노테이션을 활용해 HabitViewModel Provider를 자동 생성합니다.
/// 이 ViewModel은 상태(StateNotifier)로 AsyncValue<List<HabitModel>>를 관리하며,
/// 습관 데이터를 로딩, 성공, 에러 상태로 구분하여 UI에 전달합니다.
@riverpod
class HabitViewModel extends _$HabitViewModel {
  /// build 메서드는 Provider가 생성될 때 초기 습관 목록을 가져오기 위해 호출됩니다.
  /// Repository를 통해 비동기로 데이터를 불러오며, 이 결과는 AsyncData, AsyncLoading, AsyncError 상태로 표현됩니다.
  @override
  Future<List<HabitModel>> build() async {
    final repository = ref.watch(providerHabitRepository);
    return await repository.fetchHabits();
  }

  /// 습관 목록을 새로 고침하는 메서드입니다.
  /// 호출 시 상태를 AsyncLoading으로 설정한 후, Repository에서 최신 데이터를 받아와 AsyncData 또는 AsyncError로 업데이트합니다.
  Future<void> refreshHabits() async {
    state = const AsyncLoading();
    try {
      final habits = await ref.watch(providerHabitRepository).fetchHabits();
      state = AsyncData(habits);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// 새로운 습관을 추가하는 메서드입니다.
  /// 추가 후 refreshHabits()를 호출하여 상태를 최신 데이터로 업데이트합니다.
  Future<void> addHabit(HabitModel habit) async {
    try {
      final repository = ref.watch(providerHabitRepository);
      await repository.addHabit(habit);
      await refreshHabits(); // 추가 후 목록 새로 고침
    } catch (error) {
      // 필요 시 에러 로깅 또는 추가 처리를 할 수 있습니다.
      rethrow;
    }
  }

  /// id를 기반으로 습관을 삭제하는 메서드입니다.
  /// 삭제 후 refreshHabits()를 호출하여 최신 목록을 반영합니다.
  Future<void> deleteHabit(String id) async {
    try {
      final repository = ref.watch(providerHabitRepository);
      await repository.deleteHabit(id);
      await refreshHabits(); // 삭제 후 목록 새로 고침
    } catch (error) {
      // 필요 시 에러 처리를 추가합니다.
      rethrow;
    }
  }

  /// 기존 습관 데이터를 수정하는 메서드입니다.
  /// 수정 후 refreshHabits()를 호출하여 최신 데이터를 가져옵니다.
  Future<void> updateHabit(HabitModel habit) async {
    try {
      final repository = ref.watch(providerHabitRepository);
      await repository.updateHabit(habit);
      await refreshHabits(); // 수정 후 목록 새로 고침
    } catch (error) {
      // 에러 발생 시 호출 측에서 적절히 처리할 수 있습니다.
      rethrow;
    }
  }

  /// 단일 습관 데이터를 조회하는 메서드입니다.
  /// 이 메서드는 전체 목록 상태를 변경하지 않고, 특정 습관 정보를 반환합니다.
  Future<HabitModel?> getHabit(String id) async {
    try {
      final repository = ref.watch(providerHabitRepository);
      return await repository.getHabit(id);
    } catch (error) {
      // 조회 실패 시 null을 반환하거나 별도 에러 처리를 할 수 있습니다.
      return null;
    }
  }

  /// 오늘에 해당하는 습관 목록을 조회하는 메서드입니다.
  /// 현재 날짜의 요일(1: 월요일 ~ 7: 일요일)을 기준으로,
  /// 해당 요일에 포함된 습관만 필터링한 후 목표치(targetCount)가 높은 순서대로 정렬하여 반환합니다.
  Future<List<HabitModel>> getHabitsForToday() async {
    // 현재 요일을 구합니다. (DateTime.now().weekday는 1부터 7까지의 값을 가집니다.)
    final today = DateTime.now().weekday;

    // 전체 습관 목록을 가져오기 위해 Repository를 사용합니다.
    final repository = ref.watch(providerHabitRepository);
    final habits = await repository.fetchHabits();

    // 오늘에 해당하는 습관만 필터링합니다.
    // habit.frequency에 오늘의 요일이 포함되어 있으면 오늘 실행할 습관입니다.
    final todaysHabits =
        habits.where((habit) => habit.frequency.contains(today)).toList();

    // 목표치(targetCount)가 높은 순서대로 정렬합니다.
    todaysHabits.sort((a, b) => b.targetCount.compareTo(a.targetCount));

    return todaysHabits;
  }
}
