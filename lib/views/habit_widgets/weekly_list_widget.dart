// lib/views/habit_widgets/weekly_list_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slow_food/models/habit_model.dart';
import 'package:slow_food/themes/app_theme.dart';
import 'package:slow_food/viewmodels/habit_view_model.dart';
import 'package:slow_food/views/commons/logic.dart';
import 'package:slow_food/views/icon_data/get_icon_data.dart';

/// 주간 탭 화면을 담당하는 위젯
class WeeklyTab extends StatelessWidget {
  const WeeklyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 실제 구현에서는 주간 달력 형태로 각 요일별 체크를 표시해야 함
    // 여기서는 간단하게 HabitListWidget을 통해 전체 습관 목록을 보여줌
    return Scaffold(body: HabitListWidget());
  }
}

/// 전체 습관 목록을 리스트로 표시하는 위젯
class HabitListWidget extends ConsumerWidget {
  const HabitListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // HabitNotifier에서 습관 리스트를 구독
    final habits = ref.watch(habitViewModelProvider);
    return habits.when(
      data: (habits) {
        return ListView.builder(
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            // 각 습관 정보를 개별 HabitItemWidget으로 표시
            return HabitItemWidget(habit: habit);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

/// 개별 습관의 정보를 표시하는 위젯
class HabitItemWidget extends ConsumerWidget {
  final HabitModel habit;
  const HabitItemWidget({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekdays = getLocalizedWeekdays(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 습관 타이틀 및 목표 달성 횟수 표시 행
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 습관 아이콘 표시 (아이콘 이름이 있을 경우)
                if (habit.iconName != null)
                  Icon(
                    getIconData(habit.iconName!),
                    color: parseHexColor(habit.colorHex ?? '#000000'),
                  ),
                const SizedBox(width: 8),
                // 습관 제목 표시
                Expanded(
                  child: Text(
                    habit.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
/*                
 // 목표 달성 횟수 표시
                Text(
                  habit.targetCount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ), 
                */
              ],
            ),
            const SizedBox(height: 12),
            // 요일별 체크 여부를 표시하는 행
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekdays.asMap().entries.map((entry) {
                final index = entry.key;
                final dayLabel = entry.value;
                final dayOfWeek = index + 1; // 월요일=1, 일요일=7
                // habit.frequency에 포함된 요일은 예약된 날로 간주
                final isScheduled = habit.frequency.contains(dayOfWeek);
                // 예약된 날: habit의 색상, 미예약: 회색 처리
                final backgroundColor = isScheduled
                    ? parseHexColor(habit.colorHex ?? '#000000')
                    : parseHexColor(habit.colorHex ?? '#000000')
                        .withOpacity(0.1);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        // 요일 약어 텍스트
                        Text(
                          dayLabel,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 4),
                        // 체크 여부를 표시하는 원형 아이콘
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: backgroundColor,
                          child: const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
