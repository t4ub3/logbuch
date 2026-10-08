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
import '../pricing/fee_unit.dart' as _ivlcb7ri;
import '../rooms/room_fee.dart' as _iv47he65;

/// A surcharge or fee. What it costs is in the price lists; a list without
/// an amount for it does not charge it.
abstract class Fee
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Fee._({
    this.id,
    required this.name,
    required this.unit,
    this.ageGroupId,
    int? taxRate,
    bool? autoApply,
    this.rooms,
  }) : taxRate = taxRate ?? 0,
       autoApply = autoApply ?? false;

  factory Fee({
    int? id,
    required String name,
    required _ivlcb7ri.FeeUnit unit,
    int? ageGroupId,
    int? taxRate,
    bool? autoApply,
    List<_iv47he65.RoomFee>? rooms,
  }) = _FeeImpl;

  factory Fee.fromJson(Map<String, dynamic> jsonSerialization) {
    return Fee(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      unit: _ivlcb7ri.FeeUnit.fromJson((jsonSerialization['unit'] as String)),
      ageGroupId: jsonSerialization['ageGroupId'] as int?,
      taxRate: jsonSerialization['taxRate'] as int?,
      autoApply: jsonSerialization['autoApply'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['autoApply']),
      rooms: jsonSerialization['rooms'] == null
          ? null
          : _i7rf0d0e.Protocol().deserialize<List<_iv47he65.RoomFee>>(
              jsonSerialization['rooms'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  _ivlcb7ri.FeeUnit unit;

  int? ageGroupId;

  int taxRate;

  /// Charged to every booking. Otherwise the fee is a surcharge of the
  /// rooms it is assigned to.
  bool autoApply;

  List<_iv47he65.RoomFee>? rooms;

  /// Returns a shallow copy of this [Fee]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Fee copyWith({
    int? id,
    String? name,
    _ivlcb7ri.FeeUnit? unit,
    int? ageGroupId,
    int? taxRate,
    bool? autoApply,
    List<_iv47he65.RoomFee>? rooms,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Fee',
      if (id != null) 'id': id,
      'name': name,
      'unit': unit.toJson(),
      if (ageGroupId != null) 'ageGroupId': ageGroupId,
      'taxRate': taxRate,
      'autoApply': autoApply,
      if (rooms != null) 'rooms': rooms?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Fee',
      if (id != null) 'id': id,
      'name': name,
      'unit': unit.toJson(),
      if (ageGroupId != null) 'ageGroupId': ageGroupId,
      'taxRate': taxRate,
      'autoApply': autoApply,
      if (rooms != null)
        'rooms': rooms?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeeImpl extends Fee {
  _FeeImpl({
    int? id,
    required String name,
    required _ivlcb7ri.FeeUnit unit,
    int? ageGroupId,
    int? taxRate,
    bool? autoApply,
    List<_iv47he65.RoomFee>? rooms,
  }) : super._(
         id: id,
         name: name,
         unit: unit,
         ageGroupId: ageGroupId,
         taxRate: taxRate,
         autoApply: autoApply,
         rooms: rooms,
       );

  /// Returns a shallow copy of this [Fee]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Fee copyWith({
    Object? id = _Undefined,
    String? name,
    _ivlcb7ri.FeeUnit? unit,
    Object? ageGroupId = _Undefined,
    int? taxRate,
    bool? autoApply,
    Object? rooms = _Undefined,
  }) {
    return Fee(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      ageGroupId: ageGroupId is int? ? ageGroupId : this.ageGroupId,
      taxRate: taxRate ?? this.taxRate,
      autoApply: autoApply ?? this.autoApply,
      rooms: rooms is List<_iv47he65.RoomFee>?
          ? rooms
          : this.rooms?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
