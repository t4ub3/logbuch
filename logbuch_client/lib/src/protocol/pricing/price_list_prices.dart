/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:logbuch_client/src/protocol/protocol.dart' as _i7rf0d0e;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../pricing/fee_price.dart' as _iv8qy5wi;
import '../pricing/meal_rate.dart' as _ifmf5uvf;
import '../pricing/room_rate.dart' as _i58lj5u2;
import '../pricing/unit_price.dart' as _i17hqi9l;

/// All prices of a price list.
abstract class PriceListPrices
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PriceListPrices._({
    required this.roomRates,
    required this.unitPrices,
    required this.mealRates,
    required this.feePrices,
  });

  factory PriceListPrices({
    required List<_i58lj5u2.RoomRate> roomRates,
    required List<_i17hqi9l.UnitPrice> unitPrices,
    required List<_ifmf5uvf.MealRate> mealRates,
    required List<_iv8qy5wi.FeePrice> feePrices,
  }) = _PriceListPricesImpl;

  factory PriceListPrices.fromJson(Map<String, dynamic> jsonSerialization) {
    return PriceListPrices(
      roomRates: _i7rf0d0e.Protocol().deserialize<List<_i58lj5u2.RoomRate>>(
        jsonSerialization['roomRates'],
      ),
      unitPrices: _i7rf0d0e.Protocol().deserialize<List<_i17hqi9l.UnitPrice>>(
        jsonSerialization['unitPrices'],
      ),
      mealRates: _i7rf0d0e.Protocol().deserialize<List<_ifmf5uvf.MealRate>>(
        jsonSerialization['mealRates'],
      ),
      feePrices: _i7rf0d0e.Protocol().deserialize<List<_iv8qy5wi.FeePrice>>(
        jsonSerialization['feePrices'],
      ),
    );
  }

  List<_i58lj5u2.RoomRate> roomRates;

  List<_i17hqi9l.UnitPrice> unitPrices;

  List<_ifmf5uvf.MealRate> mealRates;

  List<_iv8qy5wi.FeePrice> feePrices;

  /// Returns a shallow copy of this [PriceListPrices]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PriceListPrices copyWith({
    List<_i58lj5u2.RoomRate>? roomRates,
    List<_i17hqi9l.UnitPrice>? unitPrices,
    List<_ifmf5uvf.MealRate>? mealRates,
    List<_iv8qy5wi.FeePrice>? feePrices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PriceListPrices',
      'roomRates': roomRates.toJson(valueToJson: (v) => v.toJson()),
      'unitPrices': unitPrices.toJson(valueToJson: (v) => v.toJson()),
      'mealRates': mealRates.toJson(valueToJson: (v) => v.toJson()),
      'feePrices': feePrices.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PriceListPrices',
      'roomRates': roomRates.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'unitPrices': unitPrices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'mealRates': mealRates.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'feePrices': feePrices.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PriceListPricesImpl extends PriceListPrices {
  _PriceListPricesImpl({
    required List<_i58lj5u2.RoomRate> roomRates,
    required List<_i17hqi9l.UnitPrice> unitPrices,
    required List<_ifmf5uvf.MealRate> mealRates,
    required List<_iv8qy5wi.FeePrice> feePrices,
  }) : super._(
         roomRates: roomRates,
         unitPrices: unitPrices,
         mealRates: mealRates,
         feePrices: feePrices,
       );

  /// Returns a shallow copy of this [PriceListPrices]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PriceListPrices copyWith({
    List<_i58lj5u2.RoomRate>? roomRates,
    List<_i17hqi9l.UnitPrice>? unitPrices,
    List<_ifmf5uvf.MealRate>? mealRates,
    List<_iv8qy5wi.FeePrice>? feePrices,
  }) {
    return PriceListPrices(
      roomRates:
          roomRates ?? this.roomRates.map((e0) => e0.copyWith()).toList(),
      unitPrices:
          unitPrices ?? this.unitPrices.map((e0) => e0.copyWith()).toList(),
      mealRates:
          mealRates ?? this.mealRates.map((e0) => e0.copyWith()).toList(),
      feePrices:
          feePrices ?? this.feePrices.map((e0) => e0.copyWith()).toList(),
    );
  }
}
