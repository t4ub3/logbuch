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

/// An option that expires soon or has expired.
abstract class ExpiringOption
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ExpiringOption._({
    required this.bookingId,
    required this.title,
    required this.expiresAt,
    this.arrival,
  });

  factory ExpiringOption({
    required int bookingId,
    required String title,
    required DateTime expiresAt,
    DateTime? arrival,
  }) = _ExpiringOptionImpl;

  factory ExpiringOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExpiringOption(
      bookingId: jsonSerialization['bookingId'] as int,
      title: jsonSerialization['title'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      arrival: jsonSerialization['arrival'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['arrival']),
    );
  }

  int bookingId;

  String title;

  DateTime expiresAt;

  DateTime? arrival;

  /// Returns a shallow copy of this [ExpiringOption]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ExpiringOption copyWith({
    int? bookingId,
    String? title,
    DateTime? expiresAt,
    DateTime? arrival,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExpiringOption',
      'bookingId': bookingId,
      'title': title,
      'expiresAt': expiresAt.toJson(),
      if (arrival != null) 'arrival': arrival?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ExpiringOption',
      'bookingId': bookingId,
      'title': title,
      'expiresAt': expiresAt.toJson(),
      if (arrival != null) 'arrival': arrival?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpiringOptionImpl extends ExpiringOption {
  _ExpiringOptionImpl({
    required int bookingId,
    required String title,
    required DateTime expiresAt,
    DateTime? arrival,
  }) : super._(
         bookingId: bookingId,
         title: title,
         expiresAt: expiresAt,
         arrival: arrival,
       );

  /// Returns a shallow copy of this [ExpiringOption]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ExpiringOption copyWith({
    int? bookingId,
    String? title,
    DateTime? expiresAt,
    Object? arrival = _Undefined,
  }) {
    return ExpiringOption(
      bookingId: bookingId ?? this.bookingId,
      title: title ?? this.title,
      expiresAt: expiresAt ?? this.expiresAt,
      arrival: arrival is DateTime? ? arrival : this.arrival,
    );
  }
}
