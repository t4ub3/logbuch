import 'package:logbuch_server/src/generated/protocol.dart';

/// The prices of a price list, of which a test only names what it needs.
/// The list they are saved for replaces the one they carry.
PriceListPrices prices({
  List<RoomRate> roomRates = const [],
  List<UnitPrice> unitPrices = const [],
  List<MealRate> mealRates = const [],
  List<FeePrice> feePrices = const [],
}) => PriceListPrices(
  roomRates: roomRates,
  unitPrices: unitPrices,
  mealRates: mealRates,
  feePrices: feePrices,
);
