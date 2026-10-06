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
import 'package:serverpod/serverpod.dart' as _is;
import '../pricing/charge_type.dart' as _iiq5obzg;

/// One position of what a booking costs. Amounts are in cents and include
/// the tax.
abstract class ChargeLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChargeLine._({
    this.guestId,
    required this.type,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.taxRate,
    this.periodFrom,
    this.periodTo,
  });

  factory ChargeLine({
    int? guestId,
    required _iiq5obzg.ChargeType type,
    required String description,
    required int quantity,
    required int unitPrice,
    required int total,
    required int taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  }) = _ChargeLineImpl;

  factory ChargeLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChargeLine(
      guestId: jsonSerialization['guestId'] as int?,
      type: _iiq5obzg.ChargeType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      description: jsonSerialization['description'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPrice: jsonSerialization['unitPrice'] as int,
      total: jsonSerialization['total'] as int,
      taxRate: jsonSerialization['taxRate'] as int,
      periodFrom: jsonSerialization['periodFrom'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['periodFrom']),
      periodTo: jsonSerialization['periodTo'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['periodTo']),
    );
  }

  /// Null for fees that are charged per booking or per room.
  int? guestId;

  _iiq5obzg.ChargeType type;

  String description;

  int quantity;

  int unitPrice;

  int total;

  /// In basis points.
  int taxRate;

  /// First night and day after the last night of a line charged per night.
  DateTime? periodFrom;

  DateTime? periodTo;

  /// Returns a shallow copy of this [ChargeLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChargeLine copyWith({
    int? guestId,
    _iiq5obzg.ChargeType? type,
    String? description,
    int? quantity,
    int? unitPrice,
    int? total,
    int? taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChargeLine',
      if (guestId != null) 'guestId': guestId,
      'type': type.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
      'taxRate': taxRate,
      if (periodFrom != null) 'periodFrom': periodFrom?.toJson(),
      if (periodTo != null) 'periodTo': periodTo?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChargeLine',
      if (guestId != null) 'guestId': guestId,
      'type': type.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
      'taxRate': taxRate,
      if (periodFrom != null) 'periodFrom': periodFrom?.toJson(),
      if (periodTo != null) 'periodTo': periodTo?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChargeLineImpl extends ChargeLine {
  _ChargeLineImpl({
    int? guestId,
    required _iiq5obzg.ChargeType type,
    required String description,
    required int quantity,
    required int unitPrice,
    required int total,
    required int taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  }) : super._(
         guestId: guestId,
         type: type,
         description: description,
         quantity: quantity,
         unitPrice: unitPrice,
         total: total,
         taxRate: taxRate,
         periodFrom: periodFrom,
         periodTo: periodTo,
       );

  /// Returns a shallow copy of this [ChargeLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChargeLine copyWith({
    Object? guestId = _Undefined,
    _iiq5obzg.ChargeType? type,
    String? description,
    int? quantity,
    int? unitPrice,
    int? total,
    int? taxRate,
    Object? periodFrom = _Undefined,
    Object? periodTo = _Undefined,
  }) {
    return ChargeLine(
      guestId: guestId is int? ? guestId : this.guestId,
      type: type ?? this.type,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      taxRate: taxRate ?? this.taxRate,
      periodFrom: periodFrom is DateTime? ? periodFrom : this.periodFrom,
      periodTo: periodTo is DateTime? ? periodTo : this.periodTo,
    );
  }
}
