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

abstract class Booking
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Booking._({
    this.id,
    DateTime? createdAt,
    required this.title,
    this.from,
    this.to,
    required this.lead,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Booking({
    int? id,
    DateTime? createdAt,
    required String title,
    DateTime? from,
    DateTime? to,
    required _imbxrfja.Contact lead,
  }) = _BookingImpl;

  factory Booking.fromJson(Map<String, dynamic> jsonSerialization) {
    return Booking(
      id: jsonSerialization['id'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      title: jsonSerialization['title'] as String,
      from: jsonSerialization['from'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: jsonSerialization['to'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      lead: _i7rf0d0e.Protocol().deserialize<_imbxrfja.Contact>(
        jsonSerialization['lead'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  DateTime createdAt;

  String title;

  DateTime? from;

  DateTime? to;

  _imbxrfja.Contact lead;

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Booking copyWith({
    int? id,
    DateTime? createdAt,
    String? title,
    DateTime? from,
    DateTime? to,
    _imbxrfja.Contact? lead,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'title': title,
      if (from != null) 'from': from?.toJson(),
      if (to != null) 'to': to?.toJson(),
      'lead': lead.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'createdAt': createdAt.toJson(),
      'title': title,
      if (from != null) 'from': from?.toJson(),
      if (to != null) 'to': to?.toJson(),
      'lead': lead.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingImpl extends Booking {
  _BookingImpl({
    int? id,
    DateTime? createdAt,
    required String title,
    DateTime? from,
    DateTime? to,
    required _imbxrfja.Contact lead,
  }) : super._(
         id: id,
         createdAt: createdAt,
         title: title,
         from: from,
         to: to,
         lead: lead,
       );

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Booking copyWith({
    Object? id = _Undefined,
    DateTime? createdAt,
    String? title,
    Object? from = _Undefined,
    Object? to = _Undefined,
    _imbxrfja.Contact? lead,
  }) {
    return Booking(
      id: id is int? ? id : this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      from: from is DateTime? ? from : this.from,
      to: to is DateTime? ? to : this.to,
      lead: lead ?? this.lead.copyWith(),
    );
  }
}
