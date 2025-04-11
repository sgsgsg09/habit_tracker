import 'package:habits_tracker/habits/models/habit_model.dart';

//레포지토리 인터페이스.
abstract interface class HabitRepository {
  Future<List<HabitModel>> fetchHabits();
  Future<HabitModel?> getHabit(String id);
  Future<void> addHabit(HabitModel habit);
  Future<void> updateHabit(HabitModel habit);
  Future<void> deleteHabit(String id);
}
