import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habits_tracker/home_widgets/home_widget_viewmodel.dart';
import 'package:habits_tracker/utils/resource/message/generated/l10n.dart';
import 'package:habits_tracker/habits/services/data_sources/local_habit_repository.dart';
import 'package:habits_tracker/utils/themes/app_theme.dart';
import 'package:habits_tracker/utils/ads/add_helper.dart';
import 'package:habits_tracker/views/habit_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  GoogleAdHelper.initializeAds();
  // Hive 초기화 (hive_flutter 패키지 사용)
  await HiveService().initializeHive();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ProviderContainer? container;

  @override
  void initState() {
    super.initState();
    // 애플리케이션 라이프사이클 관찰 등록
    WidgetsBinding.instance.addObserver(this);
    // ProviderContainer 초기화 (필요한 경우, MyApp 내 또는 별도 ProviderScope 활용)
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // InheritedWidget이 보장된 시점에서 ProviderContainer를 가져옵니다.
    container ??= ProviderScope.containerOf(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 앱 라이프사이클 변화 감지: 앱이 포그라운드/백그라운드 전환 시 갱신
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (container != null) {
      if (state == AppLifecycleState.resumed) {
        // 앱이 포그라운드로 돌아올 때 homeWidgetProvider 업데이트 호출
        container!.read(homeWidgetProvider);
        debugPrint('앱이 포그라운드로 돌아와서 homeWidgetProvider 업데이트 호출');
      } else if (state == AppLifecycleState.paused) {
        // 백그라운드 진입 시 처리 (필요에 따라)
        container!.read(homeWidgetProvider);
        debugPrint('앱이 백그라운드로 진입합니다');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 시스템 언어가 지원 목록에 없을 경우 fallback 설정
      localeResolutionCallback: (locale, supportedLocales) {
        // locale이 null이면 첫 번째 supportedLocale을 사용
        if (locale == null) {
          return supportedLocales.first;
        }
        // 지원하는 언어 목록 중, 시스템 언어와 languageCode가 같은지 확인
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        // 일치하는 언어가 없으면 첫 번째 supportedLocale로 폴백
        return supportedLocales.first;
      },
      // Flutter Intl에서 생성된 delegate들을 등록
      localizationsDelegates: const [
        Messages.delegate,
        // 아래 delegate들은 Flutter가 기본적으로 제공하는 delegate들입니다.
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Messages.delegate.supportedLocales,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
