// lib/views/widgets/habit_edit_page.dart

import 'package:flutter/material.dart';
import 'package:slow_food/models/habit_model.dart';
import 'package:slow_food/themes/app_palette.dart';
import 'package:slow_food/themes/app_theme.dart';
import 'package:slow_food/views/commons/logic.dart';
import 'package:slow_food/views/icon_data/get_icon_data.dart';
import 'package:slow_food/viewmodels/habit_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slow_food/resource/message/generated/l10n.dart';

class HabitEditPage extends ConsumerStatefulWidget {
  final HabitModel? habit;

  const HabitEditPage({Key? key, this.habit}) : super(key: key);

  @override
  _HabitEditPageState createState() => _HabitEditPageState();
}

class _HabitEditPageState extends ConsumerState<HabitEditPage> {
  late TextEditingController _titleController;
  List<int> _selectedDays = [];
  String? _selectedIcon;
  String? _selectedColor;
  bool _notificationEnabled = false;
  TimeOfDay? _notificationTime;
  bool _isActive = true;
  int _targetCount = 1;

  String? _titleError;
  String? _frequencyError;
  String? _iconError;
  String? _colorError;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _titleController = TextEditingController(text: widget.habit!.title);
      _selectedDays = List.from(widget.habit!.frequency);
      _selectedIcon = widget.habit!.iconName;
      _selectedColor =
          widget.habit!.colorHex?.replaceAll('#', '').toUpperCase();
      _notificationEnabled = widget.habit!.notificationEnabled;
      _notificationTime = widget.habit!.notificationTime != null
          ? TimeOfDay.fromDateTime(widget.habit!.notificationTime!)
          : null;
      _isActive = widget.habit!.isActive;
      _targetCount = widget.habit!.targetCount;
    } else {
      _titleController = TextEditingController();
      _targetCount = 1;
    }
  }

  DateTime? _toDateTime(TimeOfDay? time) {
    if (time == null) return null;
    return DateTime(0, 1, 1, time.hour, time.minute);
  }

  void _saveHabit() {
    bool valid = true;
    setState(() {
      _titleError = null;
      _frequencyError = null;
      _iconError = null;
      _colorError = null;
    });

    if (_titleController.text.trim().isEmpty) {
      setState(() {
        _titleError = Messages.of(context).errorHabitTitleEmpty;
      });
      valid = false;
    }
    if (_selectedDays.isEmpty) {
      setState(() {
        _frequencyError = Messages.of(context).errorRepeatDaysEmpty;
      });
      valid = false;
    }
    if (_selectedIcon == null) {
      setState(() {
        _iconError = Messages.of(context).errorSelectIcon;
      });
      valid = false;
    }
    if (_selectedColor == null) {
      setState(() {
        _colorError = Messages.of(context).errorSelectColor;
      });
      valid = false;
    }

    if (!valid) return;

    final viewModel = ref.read(habitViewModelProvider.notifier);
    final notificationTime = _toDateTime(_notificationTime);

    final newHabit = HabitModel(
      // 고유 id는 현재 시간의 밀리초 값을 사용하여 생성합니다.
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      frequency: _selectedDays,
      targetCount: _targetCount,
      iconName: _selectedIcon,
      colorHex: _selectedColor,
      notificationEnabled: _notificationEnabled,
      notificationTime: notificationTime,
      isActive: _isActive,
    );
    if (widget.habit != null) {
      viewModel.updateHabit(
        widget.habit!.copyWith(
          title: _titleController.text,
          frequency: _selectedDays,
          iconName: _selectedIcon,
          colorHex: _selectedColor,
          notificationEnabled: _notificationEnabled,
          notificationTime: notificationTime,
          isActive: _isActive,
          targetCount: _targetCount,
        ),
      );
    } else {
      viewModel.addHabit(newHabit);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppPalette.textPrimary),
        title: Text(
          widget.habit != null
              ? Messages.of(context).editHabit
              : Messages.of(context).addHabit,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        // 편집 모드(기존 모델 업데이트)일 때만 삭제 버튼을 표시합니다.
        actions: widget.habit != null
            ? [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: () async {
                    try {
                      // HabitViewModel의 deleteHabit 메서드를 호출하여 바로 삭제합니다.
                      await ref
                          .read(habitViewModelProvider.notifier)
                          .deleteHabit(widget.habit!.id);
                      // 삭제 후 이전 화면으로 돌아갑니다.
                      Navigator.pop(context);
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('삭제 실패: $error')),
                      );
                    }
                  },
                )
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Messages.of(context).habitTitle,
                style: AppTheme.editPageTextStyle,
              ),
              const SizedBox(height: 16),

              // 습관 제목 입력 필드
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: Messages.of(context).habitTitle,
                  errorText: _titleError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 반복 요일 선택 섹션
              Text(
                Messages.of(context).repeatDays,
                style: AppTheme.editPageTextStyle,
              ),
              const SizedBox(height: 16),
              FrequencySelector(
                selectedDays: _selectedDays,
                onToggle: (day) {
                  setState(() {
                    if (_selectedDays.contains(day)) {
                      _selectedDays.remove(day);
                    } else {
                      _selectedDays.add(day);
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              if (_frequencyError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _frequencyError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              // 아이콘 선택 섹션
              Text(
                Messages.of(context).selectIcon,
                style: AppTheme.editPageTextStyle,
              ),
              const SizedBox(height: 16),
              IconSelector(
                selectedIcon: _selectedIcon,
                onIconSelected: (icon) {
                  setState(() {
                    _selectedIcon = icon;
                  });
                },
              ),
              if (_iconError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _iconError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              // 색상 선택 섹션
              Text(
                Messages.of(context).selectColor,
                style: AppTheme.editPageTextStyle,
              ),
              const SizedBox(height: 8),
              ColorSelector(
                selectedColor: _selectedColor,
                onColorSelected: (colorHex) {
                  setState(() {
                    _selectedColor = colorHex;
                  });
                },
              ),
              if (_colorError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _colorError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              // 목표 횟수 조절 섹션
              Text(
                Messages.of(context).targetCount,
                style: AppTheme.editPageTextStyle,
              ),
              const SizedBox(height: 16),
              TargetCountControl(
                targetCount: _targetCount,
                onDecrement: () {
                  setState(() {
                    if (_targetCount > 1) _targetCount--;
                  });
                },
                onIncrement: () {
                  setState(() {
                    if (_targetCount < 10) _targetCount++;
                  });
                },
              ),
              /* 
              const SizedBox(height: 16),
              _buildNotificationSettings(),
              const SizedBox(height: 16),
              _buildActivationToggle(),
              */
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 40.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            ),
            onPressed: _saveHabit,
            child: Text(
              Messages.of(context).save,
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

/// 반복 요일 선택 위젯 (월~일)
class FrequencySelector extends StatelessWidget {
  final List<int> selectedDays;
  final void Function(int day) onToggle;

  const FrequencySelector({
    Key? key,
    required this.selectedDays,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weekdays = getLocalizedWeekdays(context);
    return Column(
      children: [
        // 월~금
        Row(
          children: List.generate(5, (index) {
            final day = index + 1;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FrequencyCard(
                  day: weekdays[index],
                  isSelected: selectedDays.contains(day),
                  onTap: () => onToggle(day),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        // 토, 일
        Row(
          children: List.generate(2, (index) {
            final day = index + 6;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FrequencyCard(
                  day: weekdays[index + 5],
                  isSelected: selectedDays.contains(day),
                  onTap: () => onToggle(day),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// 아이콘 선택 위젯
class IconSelector extends StatelessWidget {
  final String? selectedIcon;
  final void Function(String icon) onIconSelected;

  const IconSelector({
    Key? key,
    required this.selectedIcon,
    required this.onIconSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const icons = [
      'tint',
      'running',
      'pills',
      'spa',
      'book',
      'sun',
      'yin_yang',
      'walking',
      'journal_whills',
      'code'
    ];
    return Wrap(
      spacing: 8.0,
      children: icons.map((icon) {
        final bool isSelected = selectedIcon == icon;
        return Card(
          color: isSelected ? Colors.blueAccent : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? Colors.blueAccent : Colors.grey[300]!,
              width: 2,
            ),
          ),
          elevation: isSelected ? 4 : 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => onIconSelected(icon),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                getIconData(icon),
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// 색상 선택 위젯
class ColorSelector extends StatelessWidget {
  final String? selectedColor;
  final void Function(String hexColor) onColorSelected;

  const ColorSelector({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppPalette.peach,
      AppPalette.royalBlue,
      AppPalette.burntOrange,
      AppPalette.electricBlue,
      AppPalette.limeGreen,
      AppPalette.fuchsia,
      AppPalette.neonGreen,
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: colors.map((color) {
          final String colorHex = color.value.toRadixString(16).toUpperCase();
          final bool isSelected = selectedColor?.toUpperCase() == colorHex;
          return Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSelected ? Colors.blueAccent : Colors.transparent,
                  width: 2,
                ),
              ),
              elevation: isSelected ? 4 : 2,
              child: InkWell(
                onTap: () => onColorSelected(colorHex),
                child: Container(
                  width: 50,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 목표 횟수 조절 위젯
class TargetCountControl extends StatelessWidget {
  final int targetCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const TargetCountControl({
    Key? key,
    required this.targetCount,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.remove, size: 50),
            onPressed: onDecrement,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '$targetCount',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.add, size: 50),
            onPressed: onIncrement,
          ),
        ),
      ],
    );
  }
}

/// 요일 선택 카드 위젯
class FrequencyCard extends StatefulWidget {
  final String day;
  final bool isSelected;
  final VoidCallback onTap;

  const FrequencyCard({
    Key? key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _FrequencyCardState createState() => _FrequencyCardState();
}

class _FrequencyCardState extends State<FrequencyCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final containerStyle = Theme.of(context).extension<ContainerStyle>();
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          _scale = 0.95;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 1.0;
        });
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: containerStyle?.borderColor ?? Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: widget.isSelected
                    ? [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(widget.day),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
