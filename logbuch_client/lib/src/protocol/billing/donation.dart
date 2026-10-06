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
import '../billing/donation_source.dart' as _i6ugrixl;
import '../billing/payment.dart' as _i5od23c2;
import '../contacts/contact.dart' as _imbxrfja;
import '../donations/donation_receipt.dart' as _i8tqi4gv;

/// Money a contact gave without getting something for it. Only recorded
/// when the donor said so, never worked out from what was overpaid.
abstract class Donation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Donation._({
    this.id,
    required this.contactId,
    this.contact,
    required this.amount,
    required this.date,
    this.paymentId,
    this.payment,
    required this.source,
    this.receiptId,
    this.receipt,
  });

  factory Donation({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int amount,
    required DateTime date,
    int? paymentId,
    _i5od23c2.Payment? payment,
    required _i6ugrixl.DonationSource source,
    int? receiptId,
    _i8tqi4gv.DonationReceipt? receipt,
  }) = _DonationImpl;

  factory Donation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Donation(
      id: jsonSerialization['id'] as int?,
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
      amount: jsonSerialization['amount'] as int,
      date: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      paymentId: jsonSerialization['paymentId'] as int?,
      payment: jsonSerialization['payment'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i5od23c2.Payment>(
              jsonSerialization['payment'],
            ),
      source: _i6ugrixl.DonationSource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      receiptId: jsonSerialization['receiptId'] as int?,
      receipt: jsonSerialization['receipt'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i8tqi4gv.DonationReceipt>(
              jsonSerialization['receipt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int contactId;

  _imbxrfja.Contact? contact;

  int amount;

  DateTime date;

  int? paymentId;

  /// The payment the donation was part of, if it was left over from one.
  _i5od23c2.Payment? payment;

  _i6ugrixl.DonationSource source;

  int? receiptId;

  /// The receipt the donation is on. A donation on a receipt cannot be
  /// changed or removed anymore.
  _i8tqi4gv.DonationReceipt? receipt;

  /// Returns a shallow copy of this [Donation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Donation copyWith({
    int? id,
    int? contactId,
    _imbxrfja.Contact? contact,
    int? amount,
    DateTime? date,
    int? paymentId,
    _i5od23c2.Payment? payment,
    _i6ugrixl.DonationSource? source,
    int? receiptId,
    _i8tqi4gv.DonationReceipt? receipt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Donation',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
      'amount': amount,
      'date': date.toJson(),
      if (paymentId != null) 'paymentId': paymentId,
      if (payment != null) 'payment': payment?.toJson(),
      'source': source.toJson(),
      if (receiptId != null) 'receiptId': receiptId,
      if (receipt != null) 'receipt': receipt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Donation',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
      'amount': amount,
      'date': date.toJson(),
      if (paymentId != null) 'paymentId': paymentId,
      if (payment != null) 'payment': payment?.toJsonForProtocol(),
      'source': source.toJson(),
      if (receiptId != null) 'receiptId': receiptId,
      if (receipt != null) 'receipt': receipt?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DonationImpl extends Donation {
  _DonationImpl({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int amount,
    required DateTime date,
    int? paymentId,
    _i5od23c2.Payment? payment,
    required _i6ugrixl.DonationSource source,
    int? receiptId,
    _i8tqi4gv.DonationReceipt? receipt,
  }) : super._(
         id: id,
         contactId: contactId,
         contact: contact,
         amount: amount,
         date: date,
         paymentId: paymentId,
         payment: payment,
         source: source,
         receiptId: receiptId,
         receipt: receipt,
       );

  /// Returns a shallow copy of this [Donation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Donation copyWith({
    Object? id = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
    int? amount,
    DateTime? date,
    Object? paymentId = _Undefined,
    Object? payment = _Undefined,
    _i6ugrixl.DonationSource? source,
    Object? receiptId = _Undefined,
    Object? receipt = _Undefined,
  }) {
    return Donation(
      id: id is int? ? id : this.id,
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paymentId: paymentId is int? ? paymentId : this.paymentId,
      payment: payment is _i5od23c2.Payment?
          ? payment
          : this.payment?.copyWith(),
      source: source ?? this.source,
      receiptId: receiptId is int? ? receiptId : this.receiptId,
      receipt: receipt is _i8tqi4gv.DonationReceipt?
          ? receipt
          : this.receipt?.copyWith(),
    );
  }
}
