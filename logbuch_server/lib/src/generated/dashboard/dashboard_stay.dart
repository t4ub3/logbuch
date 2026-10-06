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
import '../bookings/booking_status.dart' as _ilk1qg37;

/// A booking that arrives or departs on a day.
abstract class DashboardStay
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DashboardStay._({
    required this.bookingId,
    required this.title,
    required this.status,
    required this.date,
    required this.leadName,
    this.guestCount,
    required this.roomCount,
  });

  factory DashboardStay({
    required int bookingId,
    required String title,
    required _ilk1qg37.BookingStatus status,
    required DateTime date,
    required String leadName,
    int? guestCount,
    required int roomCount,
  }) = _DashboardStayImpl;

  factory DashboardStay.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardStay(
      bookingId: jsonSerialization['bookingId'] as int,
      title: jsonSerialization['title'] as String,
      status: _ilk1qg37.BookingStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      date: _is.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      leadName: jsonSerialization['leadName'] as String,
      guestCount: jsonSerialization['guestCount'] as int?,
      roomCount: jsonSerialization['roomCount'] as int,
    );
  }

  int bookingId;

  String title;

  _ilk1qg37.BookingStatus status;

  /// The day of the arrival or the departure.
  DateTime date;

  String leadName;

  /// The guests on the guest list, or the expected number without one.
  int? guestCount;

  int roomCount;

  /// Returns a shallow copy of this [DashboardStay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DashboardStay copyWith({
    int? bookingId,
    String? title,
    _ilk1qg37.BookingStatus? status,
    DateTime? date,
    String? leadName,
    int? guestCount,
    int? roomCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardStay',
      'bookingId': bookingId,
      'title': title,
      'status': status.toJson(),
      'date': date.toJson(),
      'leadName': leadName,
      if (guestCount != null) 'guestCount': guestCount,
      'roomCount': roomCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardStay',
      'bookingId': bookingId,
      'title': title,
      'status': status.toJson(),
      'date': date.toJson(),
      'leadName': leadName,
      if (guestCount != null) 'guestCount': guestCount,
      'roomCount': roomCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DashboardStayImpl extends DashboardStay {
  _DashboardStayImpl({
    required int bookingId,
    required String title,
    required _ilk1qg37.BookingStatus status,
    required DateTime date,
    required String leadName,
    int? guestCount,
    required int roomCount,
  }) : super._(
         bookingId: bookingId,
         title: title,
         status: status,
         date: date,
         leadName: leadName,
         guestCount: guestCount,
         roomCount: roomCount,
       );

  /// Returns a shallow copy of this [DashboardStay]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DashboardStay copyWith({
    int? bookingId,
    String? title,
    _ilk1qg37.BookingStatus? status,
    DateTime? date,
    String? leadName,
    Object? guestCount = _Undefined,
    int? roomCount,
  }) {
    return DashboardStay(
      bookingId: bookingId ?? this.bookingId,
      title: title ?? this.title,
      status: status ?? this.status,
      date: date ?? this.date,
      leadName: leadName ?? this.leadName,
      guestCount: guestCount is int? ? guestCount : this.guestCount,
      roomCount: roomCount ?? this.roomCount,
    );
  }
}
