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
import 'package:logbuch_server/src/generated/protocol.dart' as _iil9w69f;
import 'package:serverpod/serverpod.dart' as _is;
import '../dashboard/dashboard_stay.dart' as _i87xsj5f;
import '../dashboard/expiring_option.dart' as _imkcjbpz;
import '../dashboard/meal_day.dart' as _i9ivcrt1;
import '../dashboard/open_balance.dart' as _ikyy2mzl;

/// What the start screen shows about today and the days ahead.
abstract class Dashboard
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Dashboard._({
    required this.today,
    required this.arrivals,
    required this.departures,
    required this.roomsOccupied,
    required this.roomsTotal,
    required this.guestsTonight,
    required this.expiringOptions,
    required this.openBalances,
    required this.meals,
  });

  factory Dashboard({
    required DateTime today,
    required List<_i87xsj5f.DashboardStay> arrivals,
    required List<_i87xsj5f.DashboardStay> departures,
    required int roomsOccupied,
    required int roomsTotal,
    required int guestsTonight,
    required List<_imkcjbpz.ExpiringOption> expiringOptions,
    required List<_ikyy2mzl.OpenBalance> openBalances,
    required List<_i9ivcrt1.MealDay> meals,
  }) = _DashboardImpl;

  factory Dashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return Dashboard(
      today: _is.DateTimeJsonExtension.fromJson(jsonSerialization['today']),
      arrivals: _iil9w69f.Protocol().deserialize<List<_i87xsj5f.DashboardStay>>(
        jsonSerialization['arrivals'],
      ),
      departures: _iil9w69f.Protocol()
          .deserialize<List<_i87xsj5f.DashboardStay>>(
            jsonSerialization['departures'],
          ),
      roomsOccupied: jsonSerialization['roomsOccupied'] as int,
      roomsTotal: jsonSerialization['roomsTotal'] as int,
      guestsTonight: jsonSerialization['guestsTonight'] as int,
      expiringOptions: _iil9w69f.Protocol()
          .deserialize<List<_imkcjbpz.ExpiringOption>>(
            jsonSerialization['expiringOptions'],
          ),
      openBalances: _iil9w69f.Protocol()
          .deserialize<List<_ikyy2mzl.OpenBalance>>(
            jsonSerialization['openBalances'],
          ),
      meals: _iil9w69f.Protocol().deserialize<List<_i9ivcrt1.MealDay>>(
        jsonSerialization['meals'],
      ),
    );
  }

  DateTime today;

  List<_i87xsj5f.DashboardStay> arrivals;

  List<_i87xsj5f.DashboardStay> departures;

  /// Rooms that are held tonight, out of the active rooms.
  int roomsOccupied;

  int roomsTotal;

  int guestsTonight;

  List<_imkcjbpz.ExpiringOption> expiringOptions;

  List<_ikyy2mzl.OpenBalance> openBalances;

  /// Today and tomorrow.
  List<_i9ivcrt1.MealDay> meals;

  /// Returns a shallow copy of this [Dashboard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Dashboard copyWith({
    DateTime? today,
    List<_i87xsj5f.DashboardStay>? arrivals,
    List<_i87xsj5f.DashboardStay>? departures,
    int? roomsOccupied,
    int? roomsTotal,
    int? guestsTonight,
    List<_imkcjbpz.ExpiringOption>? expiringOptions,
    List<_ikyy2mzl.OpenBalance>? openBalances,
    List<_i9ivcrt1.MealDay>? meals,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Dashboard',
      'today': today.toJson(),
      'arrivals': arrivals.toJson(valueToJson: (v) => v.toJson()),
      'departures': departures.toJson(valueToJson: (v) => v.toJson()),
      'roomsOccupied': roomsOccupied,
      'roomsTotal': roomsTotal,
      'guestsTonight': guestsTonight,
      'expiringOptions': expiringOptions.toJson(valueToJson: (v) => v.toJson()),
      'openBalances': openBalances.toJson(valueToJson: (v) => v.toJson()),
      'meals': meals.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Dashboard',
      'today': today.toJson(),
      'arrivals': arrivals.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'departures': departures.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'roomsOccupied': roomsOccupied,
      'roomsTotal': roomsTotal,
      'guestsTonight': guestsTonight,
      'expiringOptions': expiringOptions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'openBalances': openBalances.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'meals': meals.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DashboardImpl extends Dashboard {
  _DashboardImpl({
    required DateTime today,
    required List<_i87xsj5f.DashboardStay> arrivals,
    required List<_i87xsj5f.DashboardStay> departures,
    required int roomsOccupied,
    required int roomsTotal,
    required int guestsTonight,
    required List<_imkcjbpz.ExpiringOption> expiringOptions,
    required List<_ikyy2mzl.OpenBalance> openBalances,
    required List<_i9ivcrt1.MealDay> meals,
  }) : super._(
         today: today,
         arrivals: arrivals,
         departures: departures,
         roomsOccupied: roomsOccupied,
         roomsTotal: roomsTotal,
         guestsTonight: guestsTonight,
         expiringOptions: expiringOptions,
         openBalances: openBalances,
         meals: meals,
       );

  /// Returns a shallow copy of this [Dashboard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Dashboard copyWith({
    DateTime? today,
    List<_i87xsj5f.DashboardStay>? arrivals,
    List<_i87xsj5f.DashboardStay>? departures,
    int? roomsOccupied,
    int? roomsTotal,
    int? guestsTonight,
    List<_imkcjbpz.ExpiringOption>? expiringOptions,
    List<_ikyy2mzl.OpenBalance>? openBalances,
    List<_i9ivcrt1.MealDay>? meals,
  }) {
    return Dashboard(
      today: today ?? this.today,
      arrivals: arrivals ?? this.arrivals.map((e0) => e0.copyWith()).toList(),
      departures:
          departures ?? this.departures.map((e0) => e0.copyWith()).toList(),
      roomsOccupied: roomsOccupied ?? this.roomsOccupied,
      roomsTotal: roomsTotal ?? this.roomsTotal,
      guestsTonight: guestsTonight ?? this.guestsTonight,
      expiringOptions:
          expiringOptions ??
          this.expiringOptions.map((e0) => e0.copyWith()).toList(),
      openBalances:
          openBalances ?? this.openBalances.map((e0) => e0.copyWith()).toList(),
      meals: meals ?? this.meals.map((e0) => e0.copyWith()).toList(),
    );
  }
}
