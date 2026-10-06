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
import '../pricing/charge_line.dart' as _inra6azi;
import '../pricing/pricing_problem.dart' as _i2mn52om;

/// What a booking costs by the current rates and fees. Parts that cannot be
/// priced are left out of the lines and listed as problems.
abstract class BookingPrice
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BookingPrice._({
    required this.lines,
    required this.total,
    required this.problems,
  });

  factory BookingPrice({
    required List<_inra6azi.ChargeLine> lines,
    required int total,
    required List<_i2mn52om.PricingProblem> problems,
  }) = _BookingPriceImpl;

  factory BookingPrice.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookingPrice(
      lines: _iil9w69f.Protocol().deserialize<List<_inra6azi.ChargeLine>>(
        jsonSerialization['lines'],
      ),
      total: jsonSerialization['total'] as int,
      problems: _iil9w69f.Protocol()
          .deserialize<List<_i2mn52om.PricingProblem>>(
            jsonSerialization['problems'],
          ),
    );
  }

  List<_inra6azi.ChargeLine> lines;

  int total;

  List<_i2mn52om.PricingProblem> problems;

  /// Returns a shallow copy of this [BookingPrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BookingPrice copyWith({
    List<_inra6azi.ChargeLine>? lines,
    int? total,
    List<_i2mn52om.PricingProblem>? problems,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BookingPrice',
      'lines': lines.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'problems': problems.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BookingPrice',
      'lines': lines.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'problems': problems.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _BookingPriceImpl extends BookingPrice {
  _BookingPriceImpl({
    required List<_inra6azi.ChargeLine> lines,
    required int total,
    required List<_i2mn52om.PricingProblem> problems,
  }) : super._(
         lines: lines,
         total: total,
         problems: problems,
       );

  /// Returns a shallow copy of this [BookingPrice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BookingPrice copyWith({
    List<_inra6azi.ChargeLine>? lines,
    int? total,
    List<_i2mn52om.PricingProblem>? problems,
  }) {
    return BookingPrice(
      lines: lines ?? this.lines.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      problems: problems ?? this.problems.map((e0) => e0.copyWith()).toList(),
    );
  }
}
