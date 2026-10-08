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

/// What a fee costs by a price list.
abstract class FeePrice
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeePrice._({
    this.id,
    required this.priceListId,
    required this.feeId,
    required this.amount,
  });

  factory FeePrice({
    int? id,
    required int priceListId,
    required int feeId,
    required int amount,
  }) = _FeePriceImpl;

  factory FeePrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeePrice(
      id: jsonSerialization['id'] as int?,
      priceListId: jsonSerialization['priceListId'] as int,
      feeId: jsonSerialization['feeId'] as int,
      amount: jsonSerialization['amount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int priceListId;

  int feeId;

  int amount;

  /// Returns a shallow copy of this [FeePrice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeePrice copyWith({
    int? id,
    int? priceListId,
    int? feeId,
    int? amount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeePrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'feeId': feeId,
      'amount': amount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeePrice',
      if (id != null) 'id': id,
      'priceListId': priceListId,
      'feeId': feeId,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeePriceImpl extends FeePrice {
  _FeePriceImpl({
    int? id,
    required int priceListId,
    required int feeId,
    required int amount,
  }) : super._(
         id: id,
         priceListId: priceListId,
         feeId: feeId,
         amount: amount,
       );

  /// Returns a shallow copy of this [FeePrice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeePrice copyWith({
    Object? id = _Undefined,
    int? priceListId,
    int? feeId,
    int? amount,
  }) {
    return FeePrice(
      id: id is int? ? id : this.id,
      priceListId: priceListId ?? this.priceListId,
      feeId: feeId ?? this.feeId,
      amount: amount ?? this.amount,
    );
  }
}
