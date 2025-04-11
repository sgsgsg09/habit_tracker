// 예시: _updateAndroidWidget 메서드 내에 데이터 저장 후 검증하는 방법

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void testSharedPreferencesData() async {
  // 1. 테스트 환경 초기화
  SharedPreferences.setMockInitialValues({});

  // 예시 데이터: HabitModel 리스트를 JSON 문자열로 변환해서 저장한다고 가정.
  final fakeHabits = [
    {
      'title': '독서',
      'targetCount': 10,
      'currentCount': 0,
      'colorHex': '#00FF00',
    }
  ];
  final jsonString = jsonEncode(fakeHabits);

  // 실제 코드에서 SharedPreferences에 저장하는 부분을 실행 (예: _updateAndroidWidget)
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('tasks', jsonString);

  // 2. 검증: 'tasks' 키의 값이 실제 저장되었는지 읽어오기
  final storedJson = prefs.getString('tasks');

  // 3. 결과 비교
  assert(storedJson == jsonString);
  print('SharedPreferences에 데이터가 올바르게 저장되었습니다: $storedJson');
}

void main() {
  testSharedPreferencesData();
}
