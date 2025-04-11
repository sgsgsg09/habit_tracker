import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_tracker/habits/services/abstract_habit_repository.dart';
import 'package:habits_tracker/habits/services/app_habit_repository.dart';
import 'package:habits_tracker/habits/services/data_sources/local_habit_repository.dart';

/// [LocalHabitRepository]를 제공하는 Provider입니다.
/// 이 Provider는 HiveService를 통해 초기화된 Hive 박스를 전달받아 LocalHabitRepository 인스턴스를 생성합니다.
/// 주의: Hive 초기화와 박스 오픈은 앱 부트스트랩 시점에서 반드시 수행되어야 합니다.
final providerHabitRepository = Provider<HabitRepository>((ref) {
  final hiveService = HiveService();
  final habitBox = hiveService.getHabits();
  final localRepo = LocalHabitRepository(habitBox);

  return AppHabitRepository(localDataSource: localRepo);
});
