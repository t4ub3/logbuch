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

/// An invoice that is not paid in full.
abstract class OpenBalance
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OpenBalance._({
    required this.bookingId,
    required this.bookingTitle,
    required this.invoiceNumber,
    required this.payerName,
    required this.owed,
  });

  factory OpenBalance({
    required int bookingId,
    required String bookingTitle,
    required String invoiceNumber,
    required String payerName,
    required int owed,
  }) = _OpenBalanceImpl;

  factory OpenBalance.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpenBalance(
      bookingId: jsonSerialization['bookingId'] as int,
      bookingTitle: jsonSerialization['bookingTitle'] as String,
      invoiceNumber: jsonSerialization['invoiceNumber'] as String,
      payerName: jsonSerialization['payerName'] as String,
      owed: jsonSerialization['owed'] as int,
    );
  }

  int bookingId;

  String bookingTitle;

  String invoiceNumber;

  String payerName;

  /// In cents.
  int owed;

  /// Returns a shallow copy of this [OpenBalance]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OpenBalance copyWith({
    int? bookingId,
    String? bookingTitle,
    String? invoiceNumber,
    String? payerName,
    int? owed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpenBalance',
      'bookingId': bookingId,
      'bookingTitle': bookingTitle,
      'invoiceNumber': invoiceNumber,
      'payerName': payerName,
      'owed': owed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpenBalance',
      'bookingId': bookingId,
      'bookingTitle': bookingTitle,
      'invoiceNumber': invoiceNumber,
      'payerName': payerName,
      'owed': owed,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OpenBalanceImpl extends OpenBalance {
  _OpenBalanceImpl({
    required int bookingId,
    required String bookingTitle,
    required String invoiceNumber,
    required String payerName,
    required int owed,
  }) : super._(
         bookingId: bookingId,
         bookingTitle: bookingTitle,
         invoiceNumber: invoiceNumber,
         payerName: payerName,
         owed: owed,
       );

  /// Returns a shallow copy of this [OpenBalance]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OpenBalance copyWith({
    int? bookingId,
    String? bookingTitle,
    String? invoiceNumber,
    String? payerName,
    int? owed,
  }) {
    return OpenBalance(
      bookingId: bookingId ?? this.bookingId,
      bookingTitle: bookingTitle ?? this.bookingTitle,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      payerName: payerName ?? this.payerName,
      owed: owed ?? this.owed,
    );
  }
}
