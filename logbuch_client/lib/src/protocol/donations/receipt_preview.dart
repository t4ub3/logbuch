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
import '../contacts/contact.dart' as _imbxrfja;

/// What a receipt for a contact would cover, before it is issued.
abstract class ReceiptPreview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReceiptPreview._({
    required this.contact,
    required this.donationCount,
    required this.total,
    required this.addressComplete,
  });

  factory ReceiptPreview({
    required _imbxrfja.Contact contact,
    required int donationCount,
    required int total,
    required bool addressComplete,
  }) = _ReceiptPreviewImpl;

  factory ReceiptPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReceiptPreview(
      contact: _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
        jsonSerialization['contact'],
      ),
      donationCount: jsonSerialization['donationCount'] as int,
      total: jsonSerialization['total'] as int,
      addressComplete: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['addressComplete'],
      ),
    );
  }

  _imbxrfja.Contact contact;

  int donationCount;

  int total;

  /// A receipt needs the full address of the donor.
  bool addressComplete;

  /// Returns a shallow copy of this [ReceiptPreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReceiptPreview copyWith({
    _imbxrfja.Contact? contact,
    int? donationCount,
    int? total,
    bool? addressComplete,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReceiptPreview',
      'contact': contact.toJson(),
      'donationCount': donationCount,
      'total': total,
      'addressComplete': addressComplete,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReceiptPreview',
      'contact': contact.toJsonForProtocol(),
      'donationCount': donationCount,
      'total': total,
      'addressComplete': addressComplete,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ReceiptPreviewImpl extends ReceiptPreview {
  _ReceiptPreviewImpl({
    required _imbxrfja.Contact contact,
    required int donationCount,
    required int total,
    required bool addressComplete,
  }) : super._(
         contact: contact,
         donationCount: donationCount,
         total: total,
         addressComplete: addressComplete,
       );

  /// Returns a shallow copy of this [ReceiptPreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReceiptPreview copyWith({
    _imbxrfja.Contact? contact,
    int? donationCount,
    int? total,
    bool? addressComplete,
  }) {
    return ReceiptPreview(
      contact: contact ?? this.contact.copyWith(),
      donationCount: donationCount ?? this.donationCount,
      total: total ?? this.total,
      addressComplete: addressComplete ?? this.addressComplete,
    );
  }
}
