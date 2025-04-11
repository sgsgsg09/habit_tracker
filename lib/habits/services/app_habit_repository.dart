import 'package:habits_tracker/habits/models/habit_model.dart';
import 'package:habits_tracker/habits/services/data_sources/local_habit_repository.dart';
import 'package:habits_tracker/habits/services/abstract_habit_repository.dart';

class AppHabitRepository implements HabitRepository {
  AppHabitRepository({
    // required NetWokrProductRepository remoteDataSource,
    required LocalHabitRepository localDataSource,
  }) : _localDataSource = localDataSource
  // ,_remoteDataSource = remoteDataSource
  ;

  final LocalHabitRepository _localDataSource;
  // final NetworkProductRepository _remoteDataSource;

  // 로컬 데이터 소스에서 먼저 조회.
  @override
  Future<List<HabitModel>> fetchHabits() async {
    final localHabits = await _localDataSource.fetchHabits();
    //로컬 데이터 먼저 구현
    return localHabits;
  }

  @override
  Future<void> addHabit(HabitModel habit) async {
    // 현재는 로컬 데이터 소스에 위임하여 습관을 추가합니다.
    // 추후 원격 데이터 소스와 결합 시, 동기화 로직을 추가할 수 있습니다.
    await _localDataSource.addHabit(habit);
  }

  @override
  Future<void> deleteHabit(String id) async {
    // 로컬 데이터 소스에 위임하여 습관을 삭제합니다.
    // 추가로 삭제 후 동기화나 로깅 등의 처리를 할 수 있습니다.
    await _localDataSource.deleteHabit(id);
  }

  @override
  Future<HabitModel?> getHabit(String id) async {
    // 로컬 데이터 소스에서 단일 습관 데이터를 조회합니다.
    // 원격 데이터와 병합하는 로직이 필요하면 해당 로직을 추가할 수 있습니다.
    return await _localDataSource.getHabit(id);
  }

  @override
  Future<void> updateHabit(HabitModel habit) async {
    // 로컬 데이터 소스에 위임하여 습관 데이터를 업데이트합니다.
    // 업데이트 성공 후, 원격 데이터와 동기화하는 기능을 추가할 수 있습니다.
    await _localDataSource.updateHabit(habit);
  }
}
