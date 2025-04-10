//Hive 클래스 사용.

import 'package:hive_flutter/hive_flutter.dart';
import 'package:habits_tracker/models/adapters/habit_model_adapter.dart';
import 'package:habits_tracker/models/habit_model.dart';
import 'package:habits_tracker/services/abstract_habit_repository.dart';

class HiveService {
  static const String habitBoxName = 'habits';

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitModelAdapter());
    await Hive.openBox<HabitModel>(habitBoxName);
  }

  Box<HabitModel> getHabits() {
    return Hive.box<HabitModel>(habitBoxName);
  }
}

//LocalHabitRepository 클래스.
class LocalHabitRepository implements HabitRepository {
  final Box<HabitModel> _habitBox;
  LocalHabitRepository(this._habitBox);
  //Hive의 데이터를 불러옴,

// 전체 습관 리스트 읽기
  @override
  Future<List<HabitModel>> fetchHabits() async {
    return _habitBox.values.toList();
  }

  // 단일 습관 조회
  @override
  Future<HabitModel?> getHabit(String id) async {
    return _habitBox.get(id);
  }

  // 습관 추가
  @override
  Future<void> addHabit(HabitModel habit) async {
    // id를 key로 사용하여 저장 (이미 존재하면 덮어쓰기됨)
    await _habitBox.put(habit.id, habit);
  }

  // 습관 수정
  @override
  Future<void> updateHabit(HabitModel habit) async {
    // 존재 여부를 확인한 후 업데이트
    if (_habitBox.containsKey(habit.id)) {
      await _habitBox.put(habit.id, habit);
    } else {
      throw Exception("Habit with id ${habit.id} does not exist.");
    }
  }

  // 습관 삭제
  @override
  Future<void> deleteHabit(String id) async {
    await _habitBox.delete(id);
  }
}
