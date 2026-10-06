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
import '../billing/charge.dart' as _ipdcl412;
import '../billing/folio_status.dart' as _i90mh7tq;
import '../billing/payment.dart' as _i5od23c2;
import '../bookings/bookings.dart' as _i2jbfzmp;
import '../contacts/contact.dart' as _imbxrfja;

/// The account of one payer for one booking: what they are charged and
/// what they paid.
abstract class Folio
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Folio._({
    this.id,
    required this.bookingId,
    this.booking,
    required this.payerId,
    this.payer,
    _i90mh7tq.FolioStatus? status,
    this.invoiceNumber,
    this.invoicedAt,
    this.charges,
    this.payments,
  }) : status = status ?? _i90mh7tq.FolioStatus.open;

  factory Folio({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int payerId,
    _imbxrfja.Contact? payer,
    _i90mh7tq.FolioStatus? status,
    String? invoiceNumber,
    DateTime? invoicedAt,
    List<_ipdcl412.Charge>? charges,
    List<_i5od23c2.Payment>? payments,
  }) = _FolioImpl;

  factory Folio.fromJson(Map<String, dynamic> jsonSerialization) {
    return Folio(
      id: jsonSerialization['id'] as int?,
      bookingId: jsonSerialization['bookingId'] as int,
      booking: jsonSerialization['booking'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_i2jbfzmp.Booking>(
              jsonSerialization['booking'],
            ),
      payerId: jsonSerialization['payerId'] as int,
      payer: jsonSerialization['payer'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['payer'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i90mh7tq.FolioStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      invoiceNumber: jsonSerialization['invoiceNumber'] as String?,
      invoicedAt: jsonSerialization['invoicedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['invoicedAt'],
            ),
      charges: jsonSerialization['charges'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_ipdcl412.Charge>>(
              jsonSerialization['charges'],
            ),
      payments: jsonSerialization['payments'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_i5od23c2.Payment>>(
              jsonSerialization['payments'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bookingId;

  _i2jbfzmp.Booking? booking;

  int payerId;

  _imbxrfja.Contact? payer;

  _i90mh7tq.FolioStatus status;

  /// Given once when the folio is invoiced and never changed afterwards.
  String? invoiceNumber;

  /// The day of the invoice.
  DateTime? invoicedAt;

  List<_ipdcl412.Charge>? charges;

  List<_i5od23c2.Payment>? payments;

  /// Returns a shallow copy of this [Folio]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Folio copyWith({
    int? id,
    int? bookingId,
    _i2jbfzmp.Booking? booking,
    int? payerId,
    _imbxrfja.Contact? payer,
    _i90mh7tq.FolioStatus? status,
    String? invoiceNumber,
    DateTime? invoicedAt,
    List<_ipdcl412.Charge>? charges,
    List<_i5od23c2.Payment>? payments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Folio',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJson(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJson(),
      'status': status.toJson(),
      if (invoiceNumber != null) 'invoiceNumber': invoiceNumber,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      if (charges != null)
        'charges': charges?.toJson(valueToJson: (v) => v.toJson()),
      if (payments != null)
        'payments': payments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Folio',
      if (id != null) 'id': id,
      'bookingId': bookingId,
      if (booking != null) 'booking': booking?.toJsonForProtocol(),
      'payerId': payerId,
      if (payer != null) 'payer': payer?.toJsonForProtocol(),
      'status': status.toJson(),
      if (invoiceNumber != null) 'invoiceNumber': invoiceNumber,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      if (charges != null)
        'charges': charges?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (payments != null)
        'payments': payments?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FolioImpl extends Folio {
  _FolioImpl({
    int? id,
    required int bookingId,
    _i2jbfzmp.Booking? booking,
    required int payerId,
    _imbxrfja.Contact? payer,
    _i90mh7tq.FolioStatus? status,
    String? invoiceNumber,
    DateTime? invoicedAt,
    List<_ipdcl412.Charge>? charges,
    List<_i5od23c2.Payment>? payments,
  }) : super._(
         id: id,
         bookingId: bookingId,
         booking: booking,
         payerId: payerId,
         payer: payer,
         status: status,
         invoiceNumber: invoiceNumber,
         invoicedAt: invoicedAt,
         charges: charges,
         payments: payments,
       );

  /// Returns a shallow copy of this [Folio]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Folio copyWith({
    Object? id = _Undefined,
    int? bookingId,
    Object? booking = _Undefined,
    int? payerId,
    Object? payer = _Undefined,
    _i90mh7tq.FolioStatus? status,
    Object? invoiceNumber = _Undefined,
    Object? invoicedAt = _Undefined,
    Object? charges = _Undefined,
    Object? payments = _Undefined,
  }) {
    return Folio(
      id: id is int? ? id : this.id,
      bookingId: bookingId ?? this.bookingId,
      booking: booking is _i2jbfzmp.Booking?
          ? booking
          : this.booking?.copyWith(),
      payerId: payerId ?? this.payerId,
      payer: payer is _imbxrfja.Contact? ? payer : this.payer?.copyWith(),
      status: status ?? this.status,
      invoiceNumber: invoiceNumber is String?
          ? invoiceNumber
          : this.invoiceNumber,
      invoicedAt: invoicedAt is DateTime? ? invoicedAt : this.invoicedAt,
      charges: charges is List<_ipdcl412.Charge>?
          ? charges
          : this.charges?.map((e0) => e0.copyWith()).toList(),
      payments: payments is List<_i5od23c2.Payment>?
          ? payments
          : this.payments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
