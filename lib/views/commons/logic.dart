// lib/utils/color_utils.dart
import 'package:flutter/material.dart';
import 'package:slow_food/resource/message/generated/l10n.dart';

/// Hex 색상 문자열(#RRGGBB 또는 #AARRGGBB)을 [Color] 객체로 변환하는 함수
Color parseHexColor(String colorHex) {
  var hex = colorHex.replaceFirst('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse(hex, radix: 16));
}

/// BuildContext를 받아 로컬라이제이션된 요일 문자열 리스트를 반환하는 함수
List<String> getLocalizedWeekdays(BuildContext context) {
  return [
    Messages.of(context).weekdayMon,
    Messages.of(context).weekdayTue,
    Messages.of(context).weekdayWed,
    Messages.of(context).weekdayThu,
    Messages.of(context).weekdayFri,
    Messages.of(context).weekdaySat,
    Messages.of(context).weekdaySun,
  ];
}
