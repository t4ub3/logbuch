// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_rates_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The meal rates of one season.

@ProviderFor(mealRates)
final mealRatesProvider = MealRatesFamily._();

/// The meal rates of one season.

final class MealRatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MealRate>>,
          List<MealRate>,
          FutureOr<List<MealRate>>
        >
    with $FutureModifier<List<MealRate>>, $FutureProvider<List<MealRate>> {
  /// The meal rates of one season.
  MealRatesProvider._({
    required MealRatesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'mealRatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mealRatesHash();

  @override
  String toString() {
    return r'mealRatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MealRate>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MealRate>> create(Ref ref) {
    final argument = this.argument as int;
    return mealRates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MealRatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mealRatesHash() => r'1071297cbf764d3402e9243029b2101d4f1049a7';

/// The meal rates of one season.

final class MealRatesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MealRate>>, int> {
  MealRatesFamily._()
    : super(
        retry: null,
        name: r'mealRatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The meal rates of one season.

  MealRatesProvider call(int seasonId) =>
      MealRatesProvider._(argument: seasonId, from: this);

  @override
  String toString() => r'mealRatesProvider';
}
