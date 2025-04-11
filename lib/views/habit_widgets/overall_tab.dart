import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habits_tracker/habits/models/habit_model.dart';
import 'package:habits_tracker/utils/themes/app_theme.dart';
import 'package:habits_tracker/utils/ads/add_helper.dart';
import 'package:habits_tracker/utils/ads/banner_ad_widget.dart';
import 'package:habits_tracker/habits/viewmodels/habit_view_model.dart';
import 'package:habits_tracker/views/icon_data/get_icon_data.dart';

import 'package:habits_tracker/views/widgets/habit_edit_page.dart';

/// OverallTab 화면은 활성화된 습관은 ListWheelScrollView로, 비활성화된 습관은 ListView로 표시합니다.
class OverallTab extends StatelessWidget {
  const OverallTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableListExample(),
    );
  }
}

class ExpandableListExample extends ConsumerWidget {
  //banner ads.

  const ExpandableListExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // HabitViewModel의 상태(AsyncValue<List<HabitModel>>)를 구독합니다.
    final asyncHabits = ref.watch(habitViewModelProvider);

    // 2. SliverGrid로 습관 목록을 표시
    return asyncHabits.when(
      data: (habits) {
        // 오늘 요일에 해당하는 습관만 필터링 후 정렬합니다.

        final allHabits = habits.toList();
        allHabits.sort((a, b) => b.targetCount.compareTo(a.targetCount));

        return Column(
          children: [
            BannerAdWidget(),
            //광고 크기 때문에 flex를 적용해야함.
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 한 줄에 보여줄 아이콘 개수
                          mainAxisSpacing: 8, // 세로 간격
                          crossAxisSpacing: 8, // 가로 간격
                          childAspectRatio: 1.0, // 아이콘 가로세로 비율(정사각형)
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final habit = allHabits[index];
                            // 색상 문자열을 통일된 형식으로 보정해 주는 함수
                            String normalizedHex(String? hex) {
                              if (hex == null || hex.isEmpty) {
                                return '';
                              }
                              // 이미 '0xff'로 시작한다면 그대로 사용
                              if (hex.startsWith('0xff')) {
                                return hex;
                              }
                              // '#'으로 시작한다면, '#'을 '0xff'로 교체
                              if (hex.startsWith('#')) {
                                return hex.replaceFirst('#', '0xff');
                              }
                              // 아무 접두사도 없다면 '0xff'를 접두사로 붙인다
                              return '0xff$hex';
                            }

                            // 2번 방식: 색상 문자열이 '0xff...' 형태인지 검사 후, 통일된 포맷으로 변환
                            Color cardColor = Colors.blueAccent;
                            if (habit.colorHex != null &&
                                habit.colorHex!.isNotEmpty) {
                              try {
                                cardColor = Color(
                                    int.parse(normalizedHex(habit.colorHex)));
                              } catch (e) {
                                // 파싱 실패 시에는 기본 색상 사용
                                cardColor = Colors.blueAccent;
                              }
                            }

                            return HabitCard(
                              habit: habit,
                              cardColor: cardColor,
                            );
                          },
                          childCount: allHabits.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

class HabitCard extends StatefulWidget {
  final HabitModel habit;
  final Color cardColor;

  const HabitCard({Key? key, required this.habit, required this.cardColor})
      : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final containerStyle = Theme.of(context).extension<ContainerStyle>();
    return Material(
      color: Colors.transparent,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onHighlightChanged: (isHighlighted) {
            setState(() {
              _scale = isHighlighted ? 0.95 : 1.0;
            });
          },
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return HabitEditPage(habit: widget.habit);
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
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.cardColor,
                width: 2.0,
              ),
              borderRadius:
                  BorderRadius.circular(containerStyle?.borderRadius ?? 20.0),
            ),
            child: Center(
              child: Icon(
                color: widget.cardColor,
                getIconData(widget.habit.iconName ?? ''),
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
