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
import '../billing/donation.dart' as _isunzuoe;
import '../billing/folio.dart' as _i7r42ton;
import '../billing/payment_method.dart' as _ilepuntz;
import '../contacts/contact.dart' as _imbxrfja;

/// Money received for a folio, or paid back if the amount is negative.
abstract class Payment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Payment._({
    this.id,
    required this.folioId,
    this.folio,
    required this.payerId,
    this.payer,
    required this.amount,
    required this.date,
    required this.method,
    this.reference,
    this.donations,
  });

  factory Payment({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    required int payerId,
    _imbxrfja.Contact? payer,
    required int amount,
    required DateTime date,
    required _ilepuntz.PaymentMethod method,
    String? reference,
    List<_isunzuoe.Donation>? donations,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      folioId: jsonSerialization['folioId'] as int,
      folio: jsonSerialization['folio'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i7r42ton.Folio>(
              jsonSerialization['folio'],
            ),
      payerId: jsonSerialization['payerId'] as int,
      payer: jsonSerialization['payer'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['payer'],
            ),
      amount: jsonSerialization['amount'] as int,
      date: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      method: _ilepuntz.PaymentMethod.fromJson(
        (jsonSerialization['method'] as String),
      ),
      reference: jsonSerialization['reference'] as String?,
      donations: jsonSerialization['donations'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_isunzuoe.Donation>>(
              jsonSerialization['donations'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int folioId;

  _i7r42ton.Folio? folio;

  int payerId;

  _imbxrfja.Contact? payer;

  int amount;

  DateTime date;

  _ilepuntz.PaymentMethod method;

  String? reference;

  List<_isunzuoe.Donation>? donations;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Payment copyWith({
    int? id,
    int? folioId,
    _i7r42ton.Folio? folio,
    int? payerId,
    _imbxrfja.Contact? payer,
    int? amount,
    DateTime? date,
    _ilepuntz.PaymentMethod? method,
    String? reference,
    List<_isunzuoe.Donation>? donations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJson(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJson(),
      'amount': amount,
      'date': date.toJson(),
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      if (donations != null)
        'donations': donations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'folioId': folioId,
      if (folio != null) 'folio': folio?.toJsonForProtocol(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJsonForProtocol(),
      'amount': amount,
      'date': date.toJson(),
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      if (donations != null)
        'donations': donations?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int folioId,
    _i7r42ton.Folio? folio,
    required int payerId,
    _imbxrfja.Contact? payer,
    required int amount,
    required DateTime date,
    required _ilepuntz.PaymentMethod method,
    String? reference,
    List<_isunzuoe.Donation>? donations,
  }) : super._(
         id: id,
         folioId: folioId,
         folio: folio,
         payerId: payerId,
         payer: payer,
         amount: amount,
         date: date,
         method: method,
         reference: reference,
         donations: donations,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? folioId,
    Object? folio = _Undefined,
    int? payerId,
    Object? payer = _Undefined,
    int? amount,
    DateTime? date,
    _ilepuntz.PaymentMethod? method,
    Object? reference = _Undefined,
    Object? donations = _Undefined,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      folioId: folioId ?? this.folioId,
      folio: folio is _i7r42ton.Folio? ? folio : this.folio?.copyWith(),
      payerId: payerId ?? this.payerId,
      payer: payer is _imbxrfja.Contact? ? payer : this.payer?.copyWith(),
      amount: amount ?? this.amount,
      date: date ?? this.date,
      method: method ?? this.method,
      reference: reference is String? ? reference : this.reference,
      donations: donations is List<_isunzuoe.Donation>?
          ? donations
          : this.donations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
