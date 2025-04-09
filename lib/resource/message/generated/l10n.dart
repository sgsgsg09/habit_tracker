// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Messages {
  Messages();

  static Messages? _current;

  static Messages get current {
    assert(
      _current != null,
      'No instance of Messages was loaded. Try to initialize the Messages delegate before accessing Messages.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Messages> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Messages();
      Messages._current = instance;

      return instance;
    });
  }

  static Messages of(BuildContext context) {
    final instance = Messages.maybeOf(context);
    assert(
      instance != null,
      'No instance of Messages present in the widget tree. Did you add Messages.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static Messages? maybeOf(BuildContext context) {
    return Localizations.of<Messages>(context, Messages);
  }

  /// `Habit Check`
  String get Title {
    return Intl.message('Habit Check', name: 'Title', desc: '', args: []);
  }

  /// `Habit Tracker`
  String get appBarTitle {
    return Intl.message(
      'Habit Tracker',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get tabToday {
    return Intl.message('Today', name: 'tabToday', desc: '', args: []);
  }

  /// `Weekly`
  String get tabWeekly {
    return Intl.message('Weekly', name: 'tabWeekly', desc: '', args: []);
  }

  /// `Overall`
  String get tabOverall {
    return Intl.message('Overall', name: 'tabOverall', desc: '', args: []);
  }

  /// `Mon`
  String get weekdayMon {
    return Intl.message('Mon', name: 'weekdayMon', desc: '', args: []);
  }

  /// `Tue`
  String get weekdayTue {
    return Intl.message('Tue', name: 'weekdayTue', desc: '', args: []);
  }

  /// `Wed`
  String get weekdayWed {
    return Intl.message('Wed', name: 'weekdayWed', desc: '', args: []);
  }

  /// `Thu`
  String get weekdayThu {
    return Intl.message('Thu', name: 'weekdayThu', desc: '', args: []);
  }

  /// `Fri`
  String get weekdayFri {
    return Intl.message('Fri', name: 'weekdayFri', desc: '', args: []);
  }

  /// `Sat`
  String get weekdaySat {
    return Intl.message('Sat', name: 'weekdaySat', desc: '', args: []);
  }

  /// `Sun`
  String get weekdaySun {
    return Intl.message('Sun', name: 'weekdaySun', desc: '', args: []);
  }

  /// `Edit Habit`
  String get editHabit {
    return Intl.message('Edit Habit', name: 'editHabit', desc: '', args: []);
  }

  /// `Add Habit`
  String get addHabit {
    return Intl.message('Add Habit', name: 'addHabit', desc: '', args: []);
  }

  /// `Habit Title`
  String get habitTitle {
    return Intl.message('Habit Title', name: 'habitTitle', desc: '', args: []);
  }

  /// `Repeat Days`
  String get repeatDays {
    return Intl.message('Repeat Days', name: 'repeatDays', desc: '', args: []);
  }

  /// `Select Icon`
  String get selectIcon {
    return Intl.message('Select Icon', name: 'selectIcon', desc: '', args: []);
  }

  /// `Select Color`
  String get selectColor {
    return Intl.message(
      'Select Color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Target Count`
  String get targetCount {
    return Intl.message(
      'Target Count',
      name: 'targetCount',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Please enter a habit title.`
  String get errorHabitTitleEmpty {
    return Intl.message(
      'Please enter a habit title.',
      name: 'errorHabitTitleEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please select repeat days.`
  String get errorRepeatDaysEmpty {
    return Intl.message(
      'Please select repeat days.',
      name: 'errorRepeatDaysEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please select an icon.`
  String get errorSelectIcon {
    return Intl.message(
      'Please select an icon.',
      name: 'errorSelectIcon',
      desc: '',
      args: [],
    );
  }

  /// `Please select a color.`
  String get errorSelectColor {
    return Intl.message(
      'Please select a color.',
      name: 'errorSelectColor',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get notificationSettings {
    return Intl.message(
      'Notification Settings',
      name: 'notificationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `Activation`
  String get activation {
    return Intl.message('Activation', name: 'activation', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Messages> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'jp'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Messages> load(Locale locale) => Messages.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
