// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$habitViewModelHash() => r'33424f307b94a9743c6ebc32e04e76d8292b8185';

/// Riverpod의 @riverpod 어노테이션을 활용해 HabitViewModel Provider를 자동 생성합니다.
/// 이 ViewModel은 상태(StateNotifier)로 AsyncValue<List<HabitModel>>를 관리하며,
/// 습관 데이터를 로딩, 성공, 에러 상태로 구분하여 UI에 전달합니다.
///
/// Copied from [HabitViewModel].
@ProviderFor(HabitViewModel)
final habitViewModelProvider =
    AutoDisposeAsyncNotifierProvider<HabitViewModel, List<HabitModel>>.internal(
  HabitViewModel.new,
  name: r'habitViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$habitViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HabitViewModel = AutoDisposeAsyncNotifier<List<HabitModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
