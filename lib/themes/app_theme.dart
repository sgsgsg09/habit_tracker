import 'package:flutter/material.dart';
import 'app_palette.dart';
import 'dart:ui'; // ThemeExtension 및 lerpDouble 사용

/// 앱 전반에 사용되는 라이트 테마 설정
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // 커스텀 ThemeExtension 추가
      extensions: <ThemeExtension<dynamic>>[
        const ContainerStyle(
          borderColor: Colors.black,
          borderRadius: 20.0,
        ),
      ],
      // 기본 색상 설정 (AppPalette 참고)
      primaryColor: AppPalette.primaryColor,
      scaffoldBackgroundColor: Colors.white,

      // AppBar 스타일 설정
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      tabBarTheme: TabBarTheme(
        // 각 탭 라벨에 적용할 패딩 (TabBar의 padding과는 다르게 라벨 자체에 적용됨)
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        unselectedLabelColor: Colors.grey,
        indicator: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      cardTheme: CardTheme(
        // CardTheme에서 기본 margin, elevation, shape 등이 지정되어 있으면 별도로 설정할 필요가 없음
        // 그러나 개별 카드에서 다른 스타일이 필요하다면 아래와 같이 지정할 수 있음
        color: Colors.white,

        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),

      // ElevatedButton 스타일 설정
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      ),

      // 텍스트 스타일 정의 (6가지 크기 및 스타일)
      textTheme: const TextTheme(
          // displayLarge: 앱 메인 헤더 (가장 큰 제목)
          displayLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppPalette.textPrimary,
          ),
          // displayMedium: 섹션 헤더 (큰 제목)
          displayMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppPalette.textPrimary,
          ),
          // displaySmall: 서브 헤더 (중간 제목)
          displaySmall: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppPalette.textPrimary,
          ),
          // bodyLarge: 본문 텍스트 (일반 내용)
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: AppPalette.textPrimary,
          ),
          // bodyMedium: 보조 본문 텍스트 (약간 작은 본문)
          bodyMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppPalette.textPrimary,
          ),
          // bodySmall: 캡션 및 설명 텍스트 (작은 텍스트)
          bodySmall: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppPalette.textSecondary,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppPalette.textPrimary,
          )),

      // 기본 텍스트 스타일은 primaryTextTheme의 bodyLarge 사용
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppPalette.textPrimary,
        ),
      ),
    );
  }

  static const buttonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppPalette.textPrimary,
  );
  static const editPageTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppPalette.textPrimary,
  );
}

/// 커스텀 ThemeExtension: 공통 컨테이너 스타일 정의
@immutable
class ContainerStyle extends ThemeExtension<ContainerStyle> {
  /// 컨테이너의 테두리 색상
  final Color? borderColor;

  /// 컨테이너의 테두리 반경
  final double? borderRadius;

  const ContainerStyle({
    required this.borderColor,
    required this.borderRadius,
  });

  /// 새로운 값으로 복사본 생성 (값이 null이면 기존 값 유지)
  @override
  ContainerStyle copyWith({
    Color? borderColor,
    double? borderRadius,
  }) {
    return ContainerStyle(
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  /// 두 스타일 객체를 보간(interpolate)하여 반환
  @override
  ContainerStyle lerp(ThemeExtension<ContainerStyle>? other, double t) {
    if (other is! ContainerStyle) return this;
    return ContainerStyle(
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
    );
  }
}
