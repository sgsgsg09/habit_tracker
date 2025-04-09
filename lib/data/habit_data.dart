// data/habit_data.dart

import 'package:slow_food/models/habit_model.dart';
import 'package:slow_food/models/habit_record/habit_attempt.dart';
import 'package:slow_food/models/habit_record/habit_record_model.dart';

// HabitModel mock 데이터 (10개)
final List<HabitModel> mockHabits = [
  HabitModel(
    id: 'habit1',
    title: '물 10잔 마시기',
    frequency: [1, 2, 3, 4, 5, 6, 7],
    targetCount: 10,
    currentCount: 3,
    isActive: true,
    iconName: 'tint',
    colorHex: '#00BFFF',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 8, 0),
  ),
  HabitModel(
    id: 'habit2',
    title: '운동하기',
    frequency: [1, 3, 5],
    targetCount: 1,
    currentCount: 0,
    isActive: true,
    iconName: 'running',
    colorHex: '#FF4500',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 7, 0),
  ),
  HabitModel(
    id: 'habit3',
    title: '복약',
    frequency: [1, 2, 3, 4, 5, 6, 7],
    targetCount: 3,
    currentCount: 1,
    isActive: true,
    iconName: 'pills',
    colorHex: '#32CD32',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 9, 0),
  ),
  HabitModel(
    id: 'habit4',
    title: '명상',
    frequency: [1, 2, 3, 4, 5],
    targetCount: 1,
    currentCount: 0,
    isActive: true,
    iconName: 'spa',
    colorHex: '#FFD700',
    notificationEnabled: false,
    notificationTime: null,
  ),
  HabitModel(
    id: 'habit5',
    title: '책 읽기',
    frequency: [1, 2, 3, 4, 5, 6, 7],
    targetCount: 30,
    currentCount: 5,
    isActive: true,
    iconName: 'book',
    colorHex: '#8A2BE2',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 20, 0),
  ),
  HabitModel(
    id: 'habit6',
    title: '일찍 일어나기',
    frequency: [1, 2, 3, 4, 5],
    targetCount: 1,
    currentCount: 0,
    isActive: true,
    iconName: 'sun',
    colorHex: '#FF8C00',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 6, 0),
  ),
  HabitModel(
    id: 'habit7',
    title: '스트레칭',
    frequency: [1, 2, 3, 4, 5, 6, 7],
    targetCount: 1,
    currentCount: 0,
    isActive: true,
    iconName: 'yin_yang',
    colorHex: '#00FA9A',
    notificationEnabled: false,
    notificationTime: null,
  ),
  HabitModel(
    id: 'habit8',
    title: '산책하기',
    frequency: [6, 7],
    targetCount: 1,
    currentCount: 1,
    isActive: true,
    iconName: 'walking',
    colorHex: '#20B2AA',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 14, 10, 0),
  ),
  HabitModel(
    id: 'habit9',
    title: '일기 쓰기',
    frequency: [1, 2, 3, 4, 5, 6, 7],
    targetCount: 1,
    currentCount: 0,
    isActive: true,
    iconName: 'journal_whills',
    colorHex: '#FF1493',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 21, 0),
  ),
  HabitModel(
    id: 'habit10',
    title: '코딩 연습',
    frequency: [1, 2, 3, 4, 5],
    targetCount: 1,
    currentCount: 0,
    isActive: true,
    iconName: 'code',
    colorHex: '#1E90FF',
    notificationEnabled: true,
    notificationTime: DateTime(2025, 3, 13, 19, 0),
  ),
];

// HabitRecordModel mock 데이터 (각 HabitModel에 대응하는 기록)
// 개별 기록 방식(HabitAttempt)을 통해 각 습관의 시도 기록을 저장합니다.
final List<HabitRecordModel> mockHabitRecords = [
  HabitRecordModel(
    habitId: 'habit1',
    attempts: [
      HabitAttempt(date: DateTime(2025, 3, 12, 8, 0), isSuccess: true),
      HabitAttempt(date: DateTime(2025, 3, 13, 8, 0), isSuccess: true),
      HabitAttempt(date: DateTime(2025, 3, 13, 20, 0), isSuccess: false),
    ],
  ),
  HabitRecordModel(
    habitId: 'habit2',
    attempts: [],
  ),
  HabitRecordModel(
    habitId: 'habit3',
    attempts: [
      HabitAttempt(date: DateTime(2025, 3, 13, 9, 0), isSuccess: true),
    ],
  ),
  HabitRecordModel(
    habitId: 'habit4',
    attempts: [],
  ),
  HabitRecordModel(
    habitId: 'habit5',
    attempts: [
      HabitAttempt(date: DateTime(2025, 3, 10, 20, 0), isSuccess: true),
      HabitAttempt(date: DateTime(2025, 3, 11, 20, 0), isSuccess: false),
      HabitAttempt(date: DateTime(2025, 3, 12, 20, 0), isSuccess: true),
      HabitAttempt(date: DateTime(2025, 3, 13, 20, 0), isSuccess: true),
      HabitAttempt(date: DateTime(2025, 3, 13, 21, 0), isSuccess: false),
    ],
  ),
  HabitRecordModel(
    habitId: 'habit6',
    attempts: [],
  ),
  HabitRecordModel(
    habitId: 'habit7',
    attempts: [],
  ),
  HabitRecordModel(
    habitId: 'habit8',
    attempts: [
      HabitAttempt(date: DateTime(2025, 3, 14, 10, 0), isSuccess: true),
    ],
  ),
  HabitRecordModel(
    habitId: 'habit9',
    attempts: [],
  ),
  HabitRecordModel(
    habitId: 'habit10',
    attempts: [],
  ),
];
