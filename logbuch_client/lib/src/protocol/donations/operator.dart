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
import '../donations/tax_notice_type.dart' as _i8bqfpik;

/// The organisation that runs the house. Its details are printed on
/// donation receipts.
abstract class Operator
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Operator._({
    this.id,
    required this.name,
    required this.street,
    required this.zip,
    required this.city,
    required this.taxOffice,
    required this.taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    this.noticeDate,
    this.assessmentPeriod,
    required this.purposes,
    this.purposesObject,
    required this.place,
    this.signatory,
  }) : noticeType = noticeType ?? _i8bqfpik.TaxNoticeType.statutoryCompliance;

  factory Operator({
    int? id,
    required String name,
    required String street,
    required String zip,
    required String city,
    required String taxOffice,
    required String taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    DateTime? noticeDate,
    String? assessmentPeriod,
    required String purposes,
    String? purposesObject,
    required String place,
    String? signatory,
  }) = _OperatorImpl;

  factory Operator.fromJson(Map<String, dynamic> jsonSerialization) {
    return Operator(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      street: jsonSerialization['street'] as String,
      zip: jsonSerialization['zip'] as String,
      city: jsonSerialization['city'] as String,
      taxOffice: jsonSerialization['taxOffice'] as String,
      taxNumber: jsonSerialization['taxNumber'] as String,
      noticeType: jsonSerialization['noticeType'] == null
          ? null
          : _i8bqfpik.TaxNoticeType.fromJson(
              (jsonSerialization['noticeType'] as String),
            ),
      noticeDate: jsonSerialization['noticeDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['noticeDate'],
            ),
      assessmentPeriod: jsonSerialization['assessmentPeriod'] as String?,
      purposes: jsonSerialization['purposes'] as String,
      purposesObject: jsonSerialization['purposesObject'] as String?,
      place: jsonSerialization['place'] as String,
      signatory: jsonSerialization['signatory'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String street;

  String zip;

  String city;

  String taxOffice;

  String taxNumber;

  _i8bqfpik.TaxNoticeType noticeType;

  DateTime? noticeDate;

  /// The year an exemption notice was issued for.
  String? assessmentPeriod;

  /// What the operator promotes, worded to follow "zur Foerderung", such as
  /// "der Jugendhilfe".
  String purposes;

  /// The same, worded to follow "Wir foerdern nach unserer Satzung", such
  /// as "die Jugendhilfe". Only a notice by Paragraph 60a AO needs it.
  String? purposesObject;

  /// Where receipts are signed.
  String place;

  /// Who signs the receipts.
  String? signatory;

  /// Returns a shallow copy of this [Operator]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Operator copyWith({
    int? id,
    String? name,
    String? street,
    String? zip,
    String? city,
    String? taxOffice,
    String? taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    DateTime? noticeDate,
    String? assessmentPeriod,
    String? purposes,
    String? purposesObject,
    String? place,
    String? signatory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Operator',
      if (id != null) 'id': id,
      'name': name,
      'street': street,
      'zip': zip,
      'city': city,
      'taxOffice': taxOffice,
      'taxNumber': taxNumber,
      'noticeType': noticeType.toJson(),
      if (noticeDate != null) 'noticeDate': noticeDate?.toJson(),
      if (assessmentPeriod != null) 'assessmentPeriod': assessmentPeriod,
      'purposes': purposes,
      if (purposesObject != null) 'purposesObject': purposesObject,
      'place': place,
      if (signatory != null) 'signatory': signatory,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Operator',
      if (id != null) 'id': id,
      'name': name,
      'street': street,
      'zip': zip,
      'city': city,
      'taxOffice': taxOffice,
      'taxNumber': taxNumber,
      'noticeType': noticeType.toJson(),
      if (noticeDate != null) 'noticeDate': noticeDate?.toJson(),
      if (assessmentPeriod != null) 'assessmentPeriod': assessmentPeriod,
      'purposes': purposes,
      if (purposesObject != null) 'purposesObject': purposesObject,
      'place': place,
      if (signatory != null) 'signatory': signatory,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OperatorImpl extends Operator {
  _OperatorImpl({
    int? id,
    required String name,
    required String street,
    required String zip,
    required String city,
    required String taxOffice,
    required String taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    DateTime? noticeDate,
    String? assessmentPeriod,
    required String purposes,
    String? purposesObject,
    required String place,
    String? signatory,
  }) : super._(
         id: id,
         name: name,
         street: street,
         zip: zip,
         city: city,
         taxOffice: taxOffice,
         taxNumber: taxNumber,
         noticeType: noticeType,
         noticeDate: noticeDate,
         assessmentPeriod: assessmentPeriod,
         purposes: purposes,
         purposesObject: purposesObject,
         place: place,
         signatory: signatory,
       );

  /// Returns a shallow copy of this [Operator]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Operator copyWith({
    Object? id = _Undefined,
    String? name,
    String? street,
    String? zip,
    String? city,
    String? taxOffice,
    String? taxNumber,
    _i8bqfpik.TaxNoticeType? noticeType,
    Object? noticeDate = _Undefined,
    Object? assessmentPeriod = _Undefined,
    String? purposes,
    Object? purposesObject = _Undefined,
    String? place,
    Object? signatory = _Undefined,
  }) {
    return Operator(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      street: street ?? this.street,
      zip: zip ?? this.zip,
      city: city ?? this.city,
      taxOffice: taxOffice ?? this.taxOffice,
      taxNumber: taxNumber ?? this.taxNumber,
      noticeType: noticeType ?? this.noticeType,
      noticeDate: noticeDate is DateTime? ? noticeDate : this.noticeDate,
      assessmentPeriod: assessmentPeriod is String?
          ? assessmentPeriod
          : this.assessmentPeriod,
      purposes: purposes ?? this.purposes,
      purposesObject: purposesObject is String?
          ? purposesObject
          : this.purposesObject,
      place: place ?? this.place,
      signatory: signatory is String? ? signatory : this.signatory,
    );
  }
}
