// lib/views/habit_widgets/today_tab.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_tracker/models/habit_model.dart';
import 'package:habits_tracker/themes/app_theme.dart';
import 'package:habits_tracker/viewmodels/habit_view_model.dart';
import 'package:habits_tracker/themes/app_palette.dart';
import 'package:habits_tracker/views/commons/logic.dart';
import 'package:habits_tracker/views/icon_data/get_icon_data.dart';
import 'package:habits_tracker/views/widgets/habit_edit_page.dart';

/// 진행도를 막대(progress bar) 형태로 표시하는 위젯으로 분리함.
class ProgressCard extends StatelessWidget {
  final HabitModel habit;

  const ProgressCard({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = (habit.targetCount == 0)
        ? 0
        : (habit.currentCount / habit.targetCount).clamp(0.0, 1.0);
    final bool isCompleted = habit.currentCount >= habit.targetCount;
    final bool isAchieved = progress >= 1.0;
    final Color baseColor =
        (habit.colorHex != null && habit.colorHex!.isNotEmpty)
            ? parseHexColor(habit.colorHex!)
            : AppPalette.inactiveColor;
    final containerStyle = Theme.of(context).extension<ContainerStyle>();

    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: containerStyle?.borderColor ?? Colors.black,
          width: 2.0,
        ),
      ),
      child: Stack(
        children: [
          // 전체 배경
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.grey : baseColor.withOpacity(0.3),
            ),
          ),
          // 진행도 컬러 막대
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: progress, end: progress),
            duration: const Duration(milliseconds: 300),
            builder: (context, animatedProgress, child) {
              return FractionallySizedBox(
                widthFactor: animatedProgress,
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: baseColor,
              ),
            ),
          ),
          // 텍스트 및 아이콘 배치
          Positioned.fill(
            child: Row(
              children: [
                const SizedBox(width: 12),
                if (habit.iconName != null && habit.iconName!.isNotEmpty) ...[
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double iconSize = constraints.maxHeight * 0.5;
                      return Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(iconSize / 2),
                          color: Colors.white,
                        ),
                        child: Icon(
                          getIconData(habit.iconName!),
                          color: parseHexColor(habit.colorHex ?? '#000000'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    habit.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                if (isAchieved)
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                else
                  Text(
                    habit.currentCount.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// TodayTab에서는 기존에 _buildProgressCard 대신 새로 분리한 ProgressCard 위젯을 사용합니다.
class TodayTab extends ConsumerWidget {
  const TodayTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHabits = ref.watch(habitViewModelProvider);
    final containerStyle = Theme.of(context).extension<ContainerStyle>();

    return asyncHabits.when(
      data: (habits) {
        final today = DateTime.now().weekday;
        // 데이터가 준비된 후, 오늘에 해당하는 습관만 필터링합니다.
        final todayHabits =
            habits.where((habit) => habit.frequency.contains(today)).toList();

        return Scaffold(
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: todayHabits.length,
            itemBuilder: (context, index) {
              final habit = todayHabits[index];
              return AnimatedHabitCard(
                habit: habit,
                child: ProgressCard(habit: habit),
                onTap: () async {
                  if (habit.currentCount < habit.targetCount) {
                    final updated = habit.copyWith(
                      currentCount: habit.currentCount + 1,
                    );
                    await ref
                        .read(habitViewModelProvider.notifier)
                        .updateHabit(updated);
                  }
                },
                onHorizontalDragEnd: () async {
                  final newCount = max(habit.currentCount - 1, 0);
                  final updated = habit.copyWith(currentCount: newCount);
                  await ref
                      .read(habitViewModelProvider.notifier)
                      .updateHabit(updated);
                },
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return HabitEditPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final begin = const Offset(0.0, -1.0);
                    final end = Offset.zero;
                    final curve = Curves.easeInOut;
                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              width: 100,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: containerStyle?.borderColor ??
                      const Color.fromARGB(255, 0, 0, 0),
                  width: 2.0,
                ),
                borderRadius:
                    BorderRadius.circular(containerStyle?.borderRadius ?? 20.0),
              ),
              child: const Icon(
                Icons.add,
                size: 50,
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

// AnimatedHabitCard 위젯은 기존과 동일하게 유지됩니다.
class AnimatedHabitCard extends StatefulWidget {
  final HabitModel habit;
  final Widget child;
  final Future<void> Function() onTap;
  final Future<void> Function() onHorizontalDragEnd;

  const AnimatedHabitCard({
    Key? key,
    required this.habit,
    required this.child,
    required this.onTap,
    required this.onHorizontalDragEnd,
  }) : super(key: key);

  @override
  _AnimatedHabitCardState createState() => _AnimatedHabitCardState();
}

class _AnimatedHabitCardState extends State<AnimatedHabitCard> {
  double _scale = 1.0;
  double _dragOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 0.965;
        });
      },
      onTapUp: (_) async {
        setState(() {
          _scale = 1.0;
        });
        await widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragOffset = (_dragOffset + details.delta.dx).clamp(-30.0, 30.0);
        });
      },
      onHorizontalDragEnd: (_) async {
        setState(() {
          _dragOffset = 0.0;
        });
        await widget.onHorizontalDragEnd();
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: Matrix4.translationValues(_dragOffset, 0, 0),
          child: widget.child,
        ),
      ),
    );
  }
}
