/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:logbuch_client/src/protocol/auth/app_user.dart' as _il34w39i;
import 'package:logbuch_client/src/protocol/billing/donation.dart' as _ibol987g;
import 'package:logbuch_client/src/protocol/billing/folio.dart' as _in6c8fr8;
import 'package:logbuch_client/src/protocol/bookings/bookings.dart'
    as _iey0gn1f;
import 'package:logbuch_client/src/protocol/contacts/contact.dart' as _izv2jndr;
import 'package:logbuch_client/src/protocol/contacts/organization.dart'
    as _igjrrozn;
import 'package:logbuch_client/src/protocol/donations/donation_receipt.dart'
    as _i8cfzthc;
import 'package:logbuch_client/src/protocol/donations/receipt_preview.dart'
    as _imgf7vt5;
import 'package:logbuch_client/src/protocol/guests/guest_group.dart'
    as _ihpk2u4j;
import 'package:logbuch_client/src/protocol/pricing/age_group.dart'
    as _iw3hbj1z;
import 'package:logbuch_client/src/protocol/pricing/fee.dart' as _iaal8fsz;
import 'package:logbuch_client/src/protocol/pricing/meal_plan.dart'
    as _iy1yfvqt;
import 'package:logbuch_client/src/protocol/pricing/meal_rate.dart'
    as _i8b25r61;
import 'package:logbuch_client/src/protocol/pricing/price_category.dart'
    as _il8lwbsk;
import 'package:logbuch_client/src/protocol/pricing/room_rate.dart'
    as _ijssj09l;
import 'package:logbuch_client/src/protocol/pricing/season.dart' as _id21ndqx;
import 'package:logbuch_client/src/protocol/rooms/room.dart' as _i5smwbna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'auth/app_user.dart' as _ij0177b8;
import 'auth/user_role.dart' as _imfzqkbp;
import 'billing/charge.dart' as _iwk2mful;
import 'billing/donation.dart' as _i373k2rw;
import 'billing/donation_source.dart' as _i6k4nn25;
import 'billing/folio.dart' as _i94y90vb;
import 'billing/folio_status.dart' as _ieyyblrs;
import 'billing/payment.dart' as _ifq0dbbu;
import 'billing/payment_method.dart' as _irhicyww;
import 'bookings/billing_mode.dart' as _iyrhfm9w;
import 'bookings/booking_room.dart' as _icov2ydl;
import 'bookings/booking_status.dart' as _iqmkyysz;
import 'bookings/bookings.dart' as _iikb94hp;
import 'common/validation_error.dart' as _ij920vmm;
import 'common/validation_exception.dart' as _ifwcmx8g;
import 'contacts/contact.dart' as _io9atw8a;
import 'contacts/organization.dart' as _iycrigka;
import 'donations/donation_receipt.dart' as _igquyr3v;
import 'donations/operator.dart' as _i80h05fc;
import 'donations/receipt_preview.dart' as _i5pbbm36;
import 'donations/tax_notice_type.dart' as _i3nhuzax;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'guests/guest.dart' as _inxh79pp;
import 'guests/guest_group.dart' as _iar0olgw;
import 'pricing/age_group.dart' as _igvrv9tv;
import 'pricing/booking_price.dart' as _i53999gr;
import 'pricing/charge_line.dart' as _idyrztp6;
import 'pricing/charge_type.dart' as _iodpb345;
import 'pricing/fee.dart' as _igatvxgq;
import 'pricing/fee_unit.dart' as _invqlcyo;
import 'pricing/meal_plan.dart' as _iahrqsj9;
import 'pricing/meal_rate.dart' as _i79c4x61;
import 'pricing/price_category.dart' as _ilo0onje;
import 'pricing/pricing_problem.dart' as _i2s1dsvn;
import 'pricing/pricing_problem_reason.dart' as _i0jnw4ju;
import 'pricing/room_rate.dart' as _ivym9zqa;
import 'pricing/season.dart' as _i3x806ev;
import 'rooms/room.dart' as _ix383f3m;
export 'auth/app_user.dart';
export 'auth/user_role.dart';
export 'billing/charge.dart';
export 'billing/donation.dart';
export 'billing/donation_source.dart';
export 'billing/folio.dart';
export 'billing/folio_status.dart';
export 'billing/payment.dart';
export 'billing/payment_method.dart';
export 'bookings/billing_mode.dart';
export 'bookings/booking_room.dart';
export 'bookings/booking_status.dart';
export 'bookings/bookings.dart';
export 'common/validation_error.dart';
export 'common/validation_exception.dart';
export 'contacts/contact.dart';
export 'contacts/organization.dart';
export 'donations/donation_receipt.dart';
export 'donations/operator.dart';
export 'donations/receipt_preview.dart';
export 'donations/tax_notice_type.dart';
export 'greetings/greeting.dart';
export 'guests/guest.dart';
export 'guests/guest_group.dart';
export 'pricing/age_group.dart';
export 'pricing/booking_price.dart';
export 'pricing/charge_line.dart';
export 'pricing/charge_type.dart';
export 'pricing/fee.dart';
export 'pricing/fee_unit.dart';
export 'pricing/meal_plan.dart';
export 'pricing/meal_rate.dart';
export 'pricing/price_category.dart';
export 'pricing/pricing_problem.dart';
export 'pricing/pricing_problem_reason.dart';
export 'pricing/room_rate.dart';
export 'pricing/season.dart';
export 'rooms/room.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ij0177b8.AppUser) {
      return _ij0177b8.AppUser.fromJson(data) as T;
    }
    if (t == _imfzqkbp.UserRole) {
      return _imfzqkbp.UserRole.fromJson(data) as T;
    }
    if (t == _iwk2mful.Charge) {
      return _iwk2mful.Charge.fromJson(data) as T;
    }
    if (t == _i373k2rw.Donation) {
      return _i373k2rw.Donation.fromJson(data) as T;
    }
    if (t == _i6k4nn25.DonationSource) {
      return _i6k4nn25.DonationSource.fromJson(data) as T;
    }
    if (t == _i94y90vb.Folio) {
      return _i94y90vb.Folio.fromJson(data) as T;
    }
    if (t == _ieyyblrs.FolioStatus) {
      return _ieyyblrs.FolioStatus.fromJson(data) as T;
    }
    if (t == _ifq0dbbu.Payment) {
      return _ifq0dbbu.Payment.fromJson(data) as T;
    }
    if (t == _irhicyww.PaymentMethod) {
      return _irhicyww.PaymentMethod.fromJson(data) as T;
    }
    if (t == _iyrhfm9w.BillingMode) {
      return _iyrhfm9w.BillingMode.fromJson(data) as T;
    }
    if (t == _icov2ydl.BookingRoom) {
      return _icov2ydl.BookingRoom.fromJson(data) as T;
    }
    if (t == _iqmkyysz.BookingStatus) {
      return _iqmkyysz.BookingStatus.fromJson(data) as T;
    }
    if (t == _iikb94hp.Booking) {
      return _iikb94hp.Booking.fromJson(data) as T;
    }
    if (t == _ij920vmm.ValidationError) {
      return _ij920vmm.ValidationError.fromJson(data) as T;
    }
    if (t == _ifwcmx8g.ValidationException) {
      return _ifwcmx8g.ValidationException.fromJson(data) as T;
    }
    if (t == _io9atw8a.Contact) {
      return _io9atw8a.Contact.fromJson(data) as T;
    }
    if (t == _iycrigka.Organization) {
      return _iycrigka.Organization.fromJson(data) as T;
    }
    if (t == _igquyr3v.DonationReceipt) {
      return _igquyr3v.DonationReceipt.fromJson(data) as T;
    }
    if (t == _i80h05fc.Operator) {
      return _i80h05fc.Operator.fromJson(data) as T;
    }
    if (t == _i5pbbm36.ReceiptPreview) {
      return _i5pbbm36.ReceiptPreview.fromJson(data) as T;
    }
    if (t == _i3nhuzax.TaxNoticeType) {
      return _i3nhuzax.TaxNoticeType.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _inxh79pp.Guest) {
      return _inxh79pp.Guest.fromJson(data) as T;
    }
    if (t == _iar0olgw.GuestGroup) {
      return _iar0olgw.GuestGroup.fromJson(data) as T;
    }
    if (t == _igvrv9tv.AgeGroup) {
      return _igvrv9tv.AgeGroup.fromJson(data) as T;
    }
    if (t == _i53999gr.BookingPrice) {
      return _i53999gr.BookingPrice.fromJson(data) as T;
    }
    if (t == _idyrztp6.ChargeLine) {
      return _idyrztp6.ChargeLine.fromJson(data) as T;
    }
    if (t == _iodpb345.ChargeType) {
      return _iodpb345.ChargeType.fromJson(data) as T;
    }
    if (t == _igatvxgq.Fee) {
      return _igatvxgq.Fee.fromJson(data) as T;
    }
    if (t == _invqlcyo.FeeUnit) {
      return _invqlcyo.FeeUnit.fromJson(data) as T;
    }
    if (t == _iahrqsj9.MealPlan) {
      return _iahrqsj9.MealPlan.fromJson(data) as T;
    }
    if (t == _i79c4x61.MealRate) {
      return _i79c4x61.MealRate.fromJson(data) as T;
    }
    if (t == _ilo0onje.PriceCategory) {
      return _ilo0onje.PriceCategory.fromJson(data) as T;
    }
    if (t == _i2s1dsvn.PricingProblem) {
      return _i2s1dsvn.PricingProblem.fromJson(data) as T;
    }
    if (t == _i0jnw4ju.PricingProblemReason) {
      return _i0jnw4ju.PricingProblemReason.fromJson(data) as T;
    }
    if (t == _ivym9zqa.RoomRate) {
      return _ivym9zqa.RoomRate.fromJson(data) as T;
    }
    if (t == _i3x806ev.Season) {
      return _i3x806ev.Season.fromJson(data) as T;
    }
    if (t == _ix383f3m.Room) {
      return _ix383f3m.Room.fromJson(data) as T;
    }
    if (t == _isc.getType<_ij0177b8.AppUser?>()) {
      return (data != null ? _ij0177b8.AppUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imfzqkbp.UserRole?>()) {
      return (data != null ? _imfzqkbp.UserRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwk2mful.Charge?>()) {
      return (data != null ? _iwk2mful.Charge.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i373k2rw.Donation?>()) {
      return (data != null ? _i373k2rw.Donation.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6k4nn25.DonationSource?>()) {
      return (data != null ? _i6k4nn25.DonationSource.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i94y90vb.Folio?>()) {
      return (data != null ? _i94y90vb.Folio.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieyyblrs.FolioStatus?>()) {
      return (data != null ? _ieyyblrs.FolioStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifq0dbbu.Payment?>()) {
      return (data != null ? _ifq0dbbu.Payment.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irhicyww.PaymentMethod?>()) {
      return (data != null ? _irhicyww.PaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iyrhfm9w.BillingMode?>()) {
      return (data != null ? _iyrhfm9w.BillingMode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_icov2ydl.BookingRoom?>()) {
      return (data != null ? _icov2ydl.BookingRoom.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqmkyysz.BookingStatus?>()) {
      return (data != null ? _iqmkyysz.BookingStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iikb94hp.Booking?>()) {
      return (data != null ? _iikb94hp.Booking.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ij920vmm.ValidationError?>()) {
      return (data != null ? _ij920vmm.ValidationError.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifwcmx8g.ValidationException?>()) {
      return (data != null
              ? _ifwcmx8g.ValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_io9atw8a.Contact?>()) {
      return (data != null ? _io9atw8a.Contact.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iycrigka.Organization?>()) {
      return (data != null ? _iycrigka.Organization.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igquyr3v.DonationReceipt?>()) {
      return (data != null ? _igquyr3v.DonationReceipt.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i80h05fc.Operator?>()) {
      return (data != null ? _i80h05fc.Operator.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5pbbm36.ReceiptPreview?>()) {
      return (data != null ? _i5pbbm36.ReceiptPreview.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3nhuzax.TaxNoticeType?>()) {
      return (data != null ? _i3nhuzax.TaxNoticeType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inxh79pp.Guest?>()) {
      return (data != null ? _inxh79pp.Guest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iar0olgw.GuestGroup?>()) {
      return (data != null ? _iar0olgw.GuestGroup.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igvrv9tv.AgeGroup?>()) {
      return (data != null ? _igvrv9tv.AgeGroup.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i53999gr.BookingPrice?>()) {
      return (data != null ? _i53999gr.BookingPrice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idyrztp6.ChargeLine?>()) {
      return (data != null ? _idyrztp6.ChargeLine.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iodpb345.ChargeType?>()) {
      return (data != null ? _iodpb345.ChargeType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igatvxgq.Fee?>()) {
      return (data != null ? _igatvxgq.Fee.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_invqlcyo.FeeUnit?>()) {
      return (data != null ? _invqlcyo.FeeUnit.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iahrqsj9.MealPlan?>()) {
      return (data != null ? _iahrqsj9.MealPlan.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i79c4x61.MealRate?>()) {
      return (data != null ? _i79c4x61.MealRate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilo0onje.PriceCategory?>()) {
      return (data != null ? _ilo0onje.PriceCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2s1dsvn.PricingProblem?>()) {
      return (data != null ? _i2s1dsvn.PricingProblem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0jnw4ju.PricingProblemReason?>()) {
      return (data != null
              ? _i0jnw4ju.PricingProblemReason.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ivym9zqa.RoomRate?>()) {
      return (data != null ? _ivym9zqa.RoomRate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3x806ev.Season?>()) {
      return (data != null ? _i3x806ev.Season.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ix383f3m.Room?>()) {
      return (data != null ? _ix383f3m.Room.fromJson(data) : null) as T;
    }
    if (t == List<_iwk2mful.Charge>) {
      return (data as List)
              .map((e) => deserialize<_iwk2mful.Charge>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iwk2mful.Charge>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iwk2mful.Charge>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ifq0dbbu.Payment>) {
      return (data as List)
              .map((e) => deserialize<_ifq0dbbu.Payment>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ifq0dbbu.Payment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ifq0dbbu.Payment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i373k2rw.Donation>) {
      return (data as List)
              .map((e) => deserialize<_i373k2rw.Donation>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i373k2rw.Donation>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i373k2rw.Donation>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_icov2ydl.BookingRoom>) {
      return (data as List)
              .map((e) => deserialize<_icov2ydl.BookingRoom>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_icov2ydl.BookingRoom>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_icov2ydl.BookingRoom>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_inxh79pp.Guest>) {
      return (data as List).map((e) => deserialize<_inxh79pp.Guest>(e)).toList()
          as T;
    }
    if (t == _isc.getType<List<_inxh79pp.Guest>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_inxh79pp.Guest>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_idyrztp6.ChargeLine>) {
      return (data as List)
              .map((e) => deserialize<_idyrztp6.ChargeLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i2s1dsvn.PricingProblem>) {
      return (data as List)
              .map((e) => deserialize<_i2s1dsvn.PricingProblem>(e))
              .toList()
          as T;
    }
    if (t == List<_il34w39i.AppUser>) {
      return (data as List)
              .map((e) => deserialize<_il34w39i.AppUser>(e))
              .toList()
          as T;
    }
    if (t == List<_in6c8fr8.Folio>) {
      return (data as List).map((e) => deserialize<_in6c8fr8.Folio>(e)).toList()
          as T;
    }
    if (t == List<_iey0gn1f.Booking>) {
      return (data as List)
              .map((e) => deserialize<_iey0gn1f.Booking>(e))
              .toList()
          as T;
    }
    if (t == List<_i5smwbna.Room>) {
      return (data as List).map((e) => deserialize<_i5smwbna.Room>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_izv2jndr.Contact>) {
      return (data as List)
              .map((e) => deserialize<_izv2jndr.Contact>(e))
              .toList()
          as T;
    }
    if (t == List<_igjrrozn.Organization>) {
      return (data as List)
              .map((e) => deserialize<_igjrrozn.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_ibol987g.Donation>) {
      return (data as List)
              .map((e) => deserialize<_ibol987g.Donation>(e))
              .toList()
          as T;
    }
    if (t == List<_imgf7vt5.ReceiptPreview>) {
      return (data as List)
              .map((e) => deserialize<_imgf7vt5.ReceiptPreview>(e))
              .toList()
          as T;
    }
    if (t == List<_i8cfzthc.DonationReceipt>) {
      return (data as List)
              .map((e) => deserialize<_i8cfzthc.DonationReceipt>(e))
              .toList()
          as T;
    }
    if (t == List<_ihpk2u4j.GuestGroup>) {
      return (data as List)
              .map((e) => deserialize<_ihpk2u4j.GuestGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_iw3hbj1z.AgeGroup>) {
      return (data as List)
              .map((e) => deserialize<_iw3hbj1z.AgeGroup>(e))
              .toList()
          as T;
    }
    if (t == List<_iaal8fsz.Fee>) {
      return (data as List).map((e) => deserialize<_iaal8fsz.Fee>(e)).toList()
          as T;
    }
    if (t == List<_iy1yfvqt.MealPlan>) {
      return (data as List)
              .map((e) => deserialize<_iy1yfvqt.MealPlan>(e))
              .toList()
          as T;
    }
    if (t == List<_i8b25r61.MealRate>) {
      return (data as List)
              .map((e) => deserialize<_i8b25r61.MealRate>(e))
              .toList()
          as T;
    }
    if (t == List<_il8lwbsk.PriceCategory>) {
      return (data as List)
              .map((e) => deserialize<_il8lwbsk.PriceCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_ijssj09l.RoomRate>) {
      return (data as List)
              .map((e) => deserialize<_ijssj09l.RoomRate>(e))
              .toList()
          as T;
    }
    if (t == List<_id21ndqx.Season>) {
      return (data as List)
              .map((e) => deserialize<_id21ndqx.Season>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ij0177b8.AppUser => 'AppUser',
      _imfzqkbp.UserRole => 'UserRole',
      _iwk2mful.Charge => 'Charge',
      _i373k2rw.Donation => 'Donation',
      _i6k4nn25.DonationSource => 'DonationSource',
      _i94y90vb.Folio => 'Folio',
      _ieyyblrs.FolioStatus => 'FolioStatus',
      _ifq0dbbu.Payment => 'Payment',
      _irhicyww.PaymentMethod => 'PaymentMethod',
      _iyrhfm9w.BillingMode => 'BillingMode',
      _icov2ydl.BookingRoom => 'BookingRoom',
      _iqmkyysz.BookingStatus => 'BookingStatus',
      _iikb94hp.Booking => 'Booking',
      _ij920vmm.ValidationError => 'ValidationError',
      _ifwcmx8g.ValidationException => 'ValidationException',
      _io9atw8a.Contact => 'Contact',
      _iycrigka.Organization => 'Organization',
      _igquyr3v.DonationReceipt => 'DonationReceipt',
      _i80h05fc.Operator => 'Operator',
      _i5pbbm36.ReceiptPreview => 'ReceiptPreview',
      _i3nhuzax.TaxNoticeType => 'TaxNoticeType',
      _izw8z7ou.Greeting => 'Greeting',
      _inxh79pp.Guest => 'Guest',
      _iar0olgw.GuestGroup => 'GuestGroup',
      _igvrv9tv.AgeGroup => 'AgeGroup',
      _i53999gr.BookingPrice => 'BookingPrice',
      _idyrztp6.ChargeLine => 'ChargeLine',
      _iodpb345.ChargeType => 'ChargeType',
      _igatvxgq.Fee => 'Fee',
      _invqlcyo.FeeUnit => 'FeeUnit',
      _iahrqsj9.MealPlan => 'MealPlan',
      _i79c4x61.MealRate => 'MealRate',
      _ilo0onje.PriceCategory => 'PriceCategory',
      _i2s1dsvn.PricingProblem => 'PricingProblem',
      _i0jnw4ju.PricingProblemReason => 'PricingProblemReason',
      _ivym9zqa.RoomRate => 'RoomRate',
      _i3x806ev.Season => 'Season',
      _ix383f3m.Room => 'Room',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('logbuch.', '');
    }

    switch (data) {
      case _ij0177b8.AppUser():
        return 'AppUser';
      case _imfzqkbp.UserRole():
        return 'UserRole';
      case _iwk2mful.Charge():
        return 'Charge';
      case _i373k2rw.Donation():
        return 'Donation';
      case _i6k4nn25.DonationSource():
        return 'DonationSource';
      case _i94y90vb.Folio():
        return 'Folio';
      case _ieyyblrs.FolioStatus():
        return 'FolioStatus';
      case _ifq0dbbu.Payment():
        return 'Payment';
      case _irhicyww.PaymentMethod():
        return 'PaymentMethod';
      case _iyrhfm9w.BillingMode():
        return 'BillingMode';
      case _icov2ydl.BookingRoom():
        return 'BookingRoom';
      case _iqmkyysz.BookingStatus():
        return 'BookingStatus';
      case _iikb94hp.Booking():
        return 'Booking';
      case _ij920vmm.ValidationError():
        return 'ValidationError';
      case _ifwcmx8g.ValidationException():
        return 'ValidationException';
      case _io9atw8a.Contact():
        return 'Contact';
      case _iycrigka.Organization():
        return 'Organization';
      case _igquyr3v.DonationReceipt():
        return 'DonationReceipt';
      case _i80h05fc.Operator():
        return 'Operator';
      case _i5pbbm36.ReceiptPreview():
        return 'ReceiptPreview';
      case _i3nhuzax.TaxNoticeType():
        return 'TaxNoticeType';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _inxh79pp.Guest():
        return 'Guest';
      case _iar0olgw.GuestGroup():
        return 'GuestGroup';
      case _igvrv9tv.AgeGroup():
        return 'AgeGroup';
      case _i53999gr.BookingPrice():
        return 'BookingPrice';
      case _idyrztp6.ChargeLine():
        return 'ChargeLine';
      case _iodpb345.ChargeType():
        return 'ChargeType';
      case _igatvxgq.Fee():
        return 'Fee';
      case _invqlcyo.FeeUnit():
        return 'FeeUnit';
      case _iahrqsj9.MealPlan():
        return 'MealPlan';
      case _i79c4x61.MealRate():
        return 'MealRate';
      case _ilo0onje.PriceCategory():
        return 'PriceCategory';
      case _i2s1dsvn.PricingProblem():
        return 'PricingProblem';
      case _i0jnw4ju.PricingProblemReason():
        return 'PricingProblemReason';
      case _ivym9zqa.RoomRate():
        return 'RoomRate';
      case _i3x806ev.Season():
        return 'Season';
      case _ix383f3m.Room():
        return 'Room';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_ij0177b8.AppUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_imfzqkbp.UserRole>(data['data']);
    }
    if (dataClassName == 'Charge') {
      return deserialize<_iwk2mful.Charge>(data['data']);
    }
    if (dataClassName == 'Donation') {
      return deserialize<_i373k2rw.Donation>(data['data']);
    }
    if (dataClassName == 'DonationSource') {
      return deserialize<_i6k4nn25.DonationSource>(data['data']);
    }
    if (dataClassName == 'Folio') {
      return deserialize<_i94y90vb.Folio>(data['data']);
    }
    if (dataClassName == 'FolioStatus') {
      return deserialize<_ieyyblrs.FolioStatus>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_ifq0dbbu.Payment>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_irhicyww.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'BillingMode') {
      return deserialize<_iyrhfm9w.BillingMode>(data['data']);
    }
    if (dataClassName == 'BookingRoom') {
      return deserialize<_icov2ydl.BookingRoom>(data['data']);
    }
    if (dataClassName == 'BookingStatus') {
      return deserialize<_iqmkyysz.BookingStatus>(data['data']);
    }
    if (dataClassName == 'Booking') {
      return deserialize<_iikb94hp.Booking>(data['data']);
    }
    if (dataClassName == 'ValidationError') {
      return deserialize<_ij920vmm.ValidationError>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_ifwcmx8g.ValidationException>(data['data']);
    }
    if (dataClassName == 'Contact') {
      return deserialize<_io9atw8a.Contact>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_iycrigka.Organization>(data['data']);
    }
    if (dataClassName == 'DonationReceipt') {
      return deserialize<_igquyr3v.DonationReceipt>(data['data']);
    }
    if (dataClassName == 'Operator') {
      return deserialize<_i80h05fc.Operator>(data['data']);
    }
    if (dataClassName == 'ReceiptPreview') {
      return deserialize<_i5pbbm36.ReceiptPreview>(data['data']);
    }
    if (dataClassName == 'TaxNoticeType') {
      return deserialize<_i3nhuzax.TaxNoticeType>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'Guest') {
      return deserialize<_inxh79pp.Guest>(data['data']);
    }
    if (dataClassName == 'GuestGroup') {
      return deserialize<_iar0olgw.GuestGroup>(data['data']);
    }
    if (dataClassName == 'AgeGroup') {
      return deserialize<_igvrv9tv.AgeGroup>(data['data']);
    }
    if (dataClassName == 'BookingPrice') {
      return deserialize<_i53999gr.BookingPrice>(data['data']);
    }
    if (dataClassName == 'ChargeLine') {
      return deserialize<_idyrztp6.ChargeLine>(data['data']);
    }
    if (dataClassName == 'ChargeType') {
      return deserialize<_iodpb345.ChargeType>(data['data']);
    }
    if (dataClassName == 'Fee') {
      return deserialize<_igatvxgq.Fee>(data['data']);
    }
    if (dataClassName == 'FeeUnit') {
      return deserialize<_invqlcyo.FeeUnit>(data['data']);
    }
    if (dataClassName == 'MealPlan') {
      return deserialize<_iahrqsj9.MealPlan>(data['data']);
    }
    if (dataClassName == 'MealRate') {
      return deserialize<_i79c4x61.MealRate>(data['data']);
    }
    if (dataClassName == 'PriceCategory') {
      return deserialize<_ilo0onje.PriceCategory>(data['data']);
    }
    if (dataClassName == 'PricingProblem') {
      return deserialize<_i2s1dsvn.PricingProblem>(data['data']);
    }
    if (dataClassName == 'PricingProblemReason') {
      return deserialize<_i0jnw4ju.PricingProblemReason>(data['data']);
    }
    if (dataClassName == 'RoomRate') {
      return deserialize<_ivym9zqa.RoomRate>(data['data']);
    }
    if (dataClassName == 'Season') {
      return deserialize<_i3x806ev.Season>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_ix383f3m.Room>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('logbuch', this);
    _iacc.Protocol().registerHostProtocol('logbuch', this);
  }

  @override
  String getModuleName() => 'logbuch';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
