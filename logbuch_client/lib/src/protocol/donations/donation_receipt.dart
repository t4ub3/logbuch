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
import '../contacts/contact.dart' as _imbxrfja;

/// The receipt for all donations of a contact in one year
/// (Sammelbestaetigung). Once it is issued, its donations cannot change.
abstract class DonationReceipt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DonationReceipt._({
    this.id,
    required this.contactId,
    this.contact,
    required this.year,
    required this.number,
    required this.total,
    required this.issuedAt,
    this.donations,
  });

  factory DonationReceipt({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int year,
    required String number,
    required int total,
    required DateTime issuedAt,
    List<_isunzuoe.Donation>? donations,
  }) = _DonationReceiptImpl;

  factory DonationReceipt.fromJson(Map<String, dynamic> jsonSerialization) {
    return DonationReceipt(
      id: jsonSerialization['id'] as int?,
      contactId: jsonSerialization['contactId'] as int,
      contact: jsonSerialization['contact'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
              jsonSerialization['contact'],
            ),
      year: jsonSerialization['year'] as int,
      number: jsonSerialization['number'] as String,
      total: jsonSerialization['total'] as int,
      issuedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
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

  int contactId;

  _imbxrfja.Contact? contact;

  int year;

  String number;

  int total;

  /// The day the receipt was issued.
  DateTime issuedAt;

  List<_isunzuoe.Donation>? donations;

  /// Returns a shallow copy of this [DonationReceipt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DonationReceipt copyWith({
    int? id,
    int? contactId,
    _imbxrfja.Contact? contact,
    int? year,
    String? number,
    int? total,
    DateTime? issuedAt,
    List<_isunzuoe.Donation>? donations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DonationReceipt',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJson(),
      'year': year,
      'number': number,
      'total': total,
      'issuedAt': issuedAt.toJson(),
      if (donations != null)
        'donations': donations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DonationReceipt',
      if (id != null) 'id': id,
      'contactId': contactId,
      if (contact != null) 'contact': contact?.toJsonForProtocol(),
      'year': year,
      'number': number,
      'total': total,
      'issuedAt': issuedAt.toJson(),
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

class _DonationReceiptImpl extends DonationReceipt {
  _DonationReceiptImpl({
    int? id,
    required int contactId,
    _imbxrfja.Contact? contact,
    required int year,
    required String number,
    required int total,
    required DateTime issuedAt,
    List<_isunzuoe.Donation>? donations,
  }) : super._(
         id: id,
         contactId: contactId,
         contact: contact,
         year: year,
         number: number,
         total: total,
         issuedAt: issuedAt,
         donations: donations,
       );

  /// Returns a shallow copy of this [DonationReceipt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DonationReceipt copyWith({
    Object? id = _Undefined,
    int? contactId,
    Object? contact = _Undefined,
    int? year,
    String? number,
    int? total,
    DateTime? issuedAt,
    Object? donations = _Undefined,
  }) {
    return DonationReceipt(
      id: id is int? ? id : this.id,
      contactId: contactId ?? this.contactId,
      contact: contact is _imbxrfja.Contact?
          ? contact
          : this.contact?.copyWith(),
      year: year ?? this.year,
      number: number ?? this.number,
      total: total ?? this.total,
      issuedAt: issuedAt ?? this.issuedAt,
      donations: donations is List<_isunzuoe.Donation>?
          ? donations
          : this.donations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
