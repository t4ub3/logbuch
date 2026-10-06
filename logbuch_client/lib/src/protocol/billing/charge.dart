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
import '../billing/folio.dart' as _i7r42ton;
import '../guests/guest.dart' as _inwk3jth;
import '../pricing/charge_type.dart' as _iiq5obzg;

/// A position on a folio. It keeps the price it was charged with, whatever
/// happens to the rates later. Amounts are in cents and include the tax.
abstract class Charge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Charge._({
    this.id,
    required this.folioId,
    this.folio,
    this.guestId,
    this.guest,
    required this.type,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.taxRate,
    this.periodFrom,
    this.periodTo,
  });

  factory Charge({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    int? guestId,
    _inwk3jth.Guest? guest,
    required _iiq5obzg.ChargeType type,
    required String description,
    required int quantity,
    required int unitPrice,
    required int total,
    required int taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  }) = _ChargeImpl;

  factory Charge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Charge(
      id: jsonSerialization['id'] as int?,
      folioId: jsonSerialization['folioId'] as int,
      folio: jsonSerialization['folio'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i7r42ton.Folio>(
              jsonSerialization['folio'],
            ),
      guestId: jsonSerialization['guestId'] as int?,
      guest: jsonSerialization['guest'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_inwk3jth.Guest>(
              jsonSerialization['guest'],
            ),
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
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['periodFrom'],
            ),
      periodTo: jsonSerialization['periodTo'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['periodTo']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int folioId;

  _i7r42ton.Folio? folio;

  int? guestId;

  /// Null for what is charged per booking or per room, and for charges
  /// added by hand.
  _inwk3jth.Guest? guest;

  _iiq5obzg.ChargeType type;

  String description;

  int quantity;

  int unitPrice;

  int total;

  /// In basis points.
  int taxRate;

  DateTime? periodFrom;

  DateTime? periodTo;

  /// Returns a shallow copy of this [Charge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Charge copyWith({
    int? id,
    int? folioId,
    _i7r42ton.Folio? folio,
    int? guestId,
    _inwk3jth.Guest? guest,
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
      '__className__': 'Charge',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJson(),
      if (guestId != null) 'guestId': guestId,
      if (guest != null) 'guest': guest?.toJson(),
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
      '__className__': 'Charge',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJsonForProtocol(),
      if (guestId != null) 'guestId': guestId,
      if (guest != null) 'guest': guest?.toJsonForProtocol(),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChargeImpl extends Charge {
  _ChargeImpl({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    int? guestId,
    _inwk3jth.Guest? guest,
    required _iiq5obzg.ChargeType type,
    required String description,
    required int quantity,
    required int unitPrice,
    required int total,
    required int taxRate,
    DateTime? periodFrom,
    DateTime? periodTo,
  }) : super._(
         id: id,
         folioId: folioId,
         folio: folio,
         guestId: guestId,
         guest: guest,
         type: type,
         description: description,
         quantity: quantity,
         unitPrice: unitPrice,
         total: total,
         taxRate: taxRate,
         periodFrom: periodFrom,
         periodTo: periodTo,
       );

  /// Returns a shallow copy of this [Charge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Charge copyWith({
    Object? id = _Undefined,
    int? folioId,
    Object? folio = _Undefined,
    Object? guestId = _Undefined,
    Object? guest = _Undefined,
    _iiq5obzg.ChargeType? type,
    String? description,
    int? quantity,
    int? unitPrice,
    int? total,
    int? taxRate,
    Object? periodFrom = _Undefined,
    Object? periodTo = _Undefined,
  }) {
    return Charge(
      id: id is int? ? id : this.id,
      folioId: folioId ?? this.folioId,
      folio: folio is _i7r42ton.Folio? ? folio : this.folio?.copyWith(),
      guestId: guestId is int? ? guestId : this.guestId,
      guest: guest is _inwk3jth.Guest? ? guest : this.guest?.copyWith(),
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
