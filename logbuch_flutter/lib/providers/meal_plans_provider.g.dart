// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mealPlans)
final mealPlansProvider = MealPlansProvider._();

final class MealPlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MealPlan>>,
          List<MealPlan>,
          FutureOr<List<MealPlan>>
        >
    with $FutureModifier<List<MealPlan>>, $FutureProvider<List<MealPlan>> {
  MealPlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealPlansProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealPlansHash();

  @$internal
  @override
  $FutureProviderElement<List<MealPlan>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MealPlan>> create(Ref ref) {
    return mealPlans(ref);
  }
}

String _$mealPlansHash() => r'0b1360c66742c980ef54b7be2794a3d4b42de89a';
