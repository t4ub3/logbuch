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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// What a unit of a type costs as a whole, whoever stays in it.
abstract class UnitPrice
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UnitPrice._({
    this.id,
    required this.priceListId,
    required this.unitTypeId,
    this.pricePerNight,
    this.dayUsePrice,
  });

  factory UnitPrice({
    int? id,
    required int priceListId,
    required int unitTypeId,
    int? pricePerNight,
    int? dayUsePrice,
  }) = _UnitPriceImpl;

  factory UnitPrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return UnitPrice(
      id: jsonSerialization['id'] as int?,
      priceListId: jsonSerialization['priceListId'] as int,
      unitTypeId: jsonSerialization['unitTypeId'] as int,
      pricePerNight: jsonSerialization['pricePerNight'] as int?,
      dayUsePrice: jsonSerialization['dayUsePrice'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int priceListId;

  int unitTypeId;

  /// Null if the unit itself costs nothing and only its guests pay.
  int? pricePerNight;

  /// What a booking that arrives and departs on the same day pays.
  int? dayUsePrice;

  /// Returns a shallow copy of this [UnitPrice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UnitPrice copyWith({
    int? id,
    int? priceListId,
    int? unitTypeId,
    int? pricePerNight,
    int? dayUsePrice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UnitPrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'unitTypeId': unitTypeId,
      if (pricePerNight != null) 'pricePerNight': pricePerNight,
      if (dayUsePrice != null) 'dayUsePrice': dayUsePrice,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UnitPrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'unitTypeId': unitTypeId,
      if (pricePerNight != null) 'pricePerNight': pricePerNight,
      if (dayUsePrice != null) 'dayUsePrice': dayUsePrice,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UnitPriceImpl extends UnitPrice {
  _UnitPriceImpl({
    int? id,
    required int priceListId,
    required int unitTypeId,
    int? pricePerNight,
    int? dayUsePrice,
  }) : super._(
         id: id,
         priceListId: priceListId,
         unitTypeId: unitTypeId,
         pricePerNight: pricePerNight,
         dayUsePrice: dayUsePrice,
       );

  /// Returns a shallow copy of this [UnitPrice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UnitPrice copyWith({
    Object? id = _Undefined,
    int? priceListId,
    int? unitTypeId,
    Object? pricePerNight = _Undefined,
    Object? dayUsePrice = _Undefined,
  }) {
    return UnitPrice(
      id: id is int? ? id : this.id,
      priceListId: priceListId ?? this.priceListId,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      pricePerNight: pricePerNight is int? ? pricePerNight : this.pricePerNight,
      dayUsePrice: dayUsePrice is int? ? dayUsePrice : this.dayUsePrice,
    );
  }
}
