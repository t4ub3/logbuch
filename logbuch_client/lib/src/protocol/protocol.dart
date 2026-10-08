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
import 'package:logbuch_client/src/protocol/bookings/booking_category.dart'
    as _i7p8ds8x;
import 'package:logbuch_client/src/protocol/bookings/bookings.dart'
    as _iey0gn1f;
import 'package:logbuch_client/src/protocol/contacts/contact.dart' as _izv2jndr;
import 'package:logbuch_client/src/protocol/contacts/household.dart'
    as _if2jdwd3;
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
import 'package:logbuch_client/src/protocol/pricing/price_list.dart'
    as _ivembrbw;
import 'package:logbuch_client/src/protocol/pricing/unit_type.dart'
    as _in0tyb01;
import 'package:logbuch_client/src/protocol/rooms/building.dart' as _iqh700fx;
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
import 'bookings/booking_category.dart' as _i8gi3061;
import 'bookings/booking_category_color.dart' as _igo3tr50;
import 'bookings/booking_category_icon.dart' as _iso9e2pg;
import 'bookings/booking_room.dart' as _icov2ydl;
import 'bookings/booking_status.dart' as _iqmkyysz;
import 'bookings/bookings.dart' as _iikb94hp;
import 'common/validation_error.dart' as _ij920vmm;
import 'common/validation_exception.dart' as _ifwcmx8g;
import 'contacts/contact.dart' as _io9atw8a;
import 'contacts/household.dart' as _itj5x341;
import 'contacts/household_member.dart' as _i1si4u4r;
import 'contacts/organization.dart' as _iycrigka;
import 'dashboard/dashboard.dart' as _iggja872;
import 'dashboard/dashboard_stay.dart' as _i9cu7oi7;
import 'dashboard/expiring_option.dart' as _iklsr4n4;
import 'dashboard/meal_booking.dart' as _igw13nlg;
import 'dashboard/meal_day.dart' as _il8j3w9m;
import 'dashboard/open_balance.dart' as _iwoe631f;
import 'donations/donation_receipt.dart' as _igquyr3v;
import 'donations/operator.dart' as _i80h05fc;
import 'donations/receipt_preview.dart' as _i5pbbm36;
import 'donations/tax_notice_type.dart' as _i3nhuzax;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'guests/age_group_count.dart' as _i409y09h;
import 'guests/dietary_need.dart' as _i7fy7mhe;
import 'guests/guest.dart' as _inxh79pp;
import 'guests/guest_group.dart' as _iar0olgw;
import 'guests/kitchen_overview.dart' as _ijaatehs;
import 'pricing/age_group.dart' as _igvrv9tv;
import 'pricing/booking_price.dart' as _i53999gr;
import 'pricing/charge_line.dart' as _idyrztp6;
import 'pricing/charge_type.dart' as _iodpb345;
import 'pricing/fee.dart' as _igatvxgq;
import 'pricing/fee_price.dart' as _idwz9zuu;
import 'pricing/fee_unit.dart' as _invqlcyo;
import 'pricing/meal_plan.dart' as _iahrqsj9;
import 'pricing/meal_rate.dart' as _i79c4x61;
import 'pricing/price_list.dart' as _iywc4zrq;
import 'pricing/price_list_prices.dart' as _i0r81qjm;
import 'pricing/pricing_problem.dart' as _i2s1dsvn;
import 'pricing/pricing_problem_reason.dart' as _i0jnw4ju;
import 'pricing/room_rate.dart' as _ivym9zqa;
import 'pricing/unit_price.dart' as _irmv8dws;
import 'pricing/unit_type.dart' as _ihus81hy;
import 'rooms/building.dart' as _iqh2u036;
import 'rooms/room.dart' as _ix383f3m;
import 'rooms/room_fee.dart' as _i14ck3rp;
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
export 'bookings/booking_category.dart';
export 'bookings/booking_category_color.dart';
export 'bookings/booking_category_icon.dart';
export 'bookings/booking_room.dart';
export 'bookings/booking_status.dart';
export 'bookings/bookings.dart';
export 'common/validation_error.dart';
export 'common/validation_exception.dart';
export 'contacts/contact.dart';
export 'contacts/household.dart';
export 'contacts/household_member.dart';
export 'contacts/organization.dart';
export 'dashboard/dashboard.dart';
export 'dashboard/dashboard_stay.dart';
export 'dashboard/expiring_option.dart';
export 'dashboard/meal_booking.dart';
export 'dashboard/meal_day.dart';
export 'dashboard/open_balance.dart';
export 'donations/donation_receipt.dart';
export 'donations/operator.dart';
export 'donations/receipt_preview.dart';
export 'donations/tax_notice_type.dart';
export 'greetings/greeting.dart';
export 'guests/age_group_count.dart';
export 'guests/dietary_need.dart';
export 'guests/guest.dart';
export 'guests/guest_group.dart';
export 'guests/kitchen_overview.dart';
export 'pricing/age_group.dart';
export 'pricing/booking_price.dart';
export 'pricing/charge_line.dart';
export 'pricing/charge_type.dart';
export 'pricing/fee.dart';
export 'pricing/fee_price.dart';
export 'pricing/fee_unit.dart';
export 'pricing/meal_plan.dart';
export 'pricing/meal_rate.dart';
export 'pricing/price_list.dart';
export 'pricing/price_list_prices.dart';
export 'pricing/pricing_problem.dart';
export 'pricing/pricing_problem_reason.dart';
export 'pricing/room_rate.dart';
export 'pricing/unit_price.dart';
export 'pricing/unit_type.dart';
export 'rooms/building.dart';
export 'rooms/room.dart';
export 'rooms/room_fee.dart';
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
    if (t == _i8gi3061.BookingCategory) {
      return _i8gi3061.BookingCategory.fromJson(data) as T;
    }
    if (t == _igo3tr50.BookingCategoryColor) {
      return _igo3tr50.BookingCategoryColor.fromJson(data) as T;
    }
    if (t == _iso9e2pg.BookingCategoryIcon) {
      return _iso9e2pg.BookingCategoryIcon.fromJson(data) as T;
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
    if (t == _itj5x341.Household) {
      return _itj5x341.Household.fromJson(data) as T;
    }
    if (t == _i1si4u4r.HouseholdMember) {
      return _i1si4u4r.HouseholdMember.fromJson(data) as T;
    }
    if (t == _iycrigka.Organization) {
      return _iycrigka.Organization.fromJson(data) as T;
    }
    if (t == _iggja872.Dashboard) {
      return _iggja872.Dashboard.fromJson(data) as T;
    }
    if (t == _i9cu7oi7.DashboardStay) {
      return _i9cu7oi7.DashboardStay.fromJson(data) as T;
    }
    if (t == _iklsr4n4.ExpiringOption) {
      return _iklsr4n4.ExpiringOption.fromJson(data) as T;
    }
    if (t == _igw13nlg.MealBooking) {
      return _igw13nlg.MealBooking.fromJson(data) as T;
    }
    if (t == _il8j3w9m.MealDay) {
      return _il8j3w9m.MealDay.fromJson(data) as T;
    }
    if (t == _iwoe631f.OpenBalance) {
      return _iwoe631f.OpenBalance.fromJson(data) as T;
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
    if (t == _i409y09h.AgeGroupCount) {
      return _i409y09h.AgeGroupCount.fromJson(data) as T;
    }
    if (t == _i7fy7mhe.DietaryNeed) {
      return _i7fy7mhe.DietaryNeed.fromJson(data) as T;
    }
    if (t == _inxh79pp.Guest) {
      return _inxh79pp.Guest.fromJson(data) as T;
    }
    if (t == _iar0olgw.GuestGroup) {
      return _iar0olgw.GuestGroup.fromJson(data) as T;
    }
    if (t == _ijaatehs.KitchenOverview) {
      return _ijaatehs.KitchenOverview.fromJson(data) as T;
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
    if (t == _idwz9zuu.FeePrice) {
      return _idwz9zuu.FeePrice.fromJson(data) as T;
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
    if (t == _iywc4zrq.PriceList) {
      return _iywc4zrq.PriceList.fromJson(data) as T;
    }
    if (t == _i0r81qjm.PriceListPrices) {
      return _i0r81qjm.PriceListPrices.fromJson(data) as T;
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
    if (t == _irmv8dws.UnitPrice) {
      return _irmv8dws.UnitPrice.fromJson(data) as T;
    }
    if (t == _ihus81hy.UnitType) {
      return _ihus81hy.UnitType.fromJson(data) as T;
    }
    if (t == _iqh2u036.Building) {
      return _iqh2u036.Building.fromJson(data) as T;
    }
    if (t == _ix383f3m.Room) {
      return _ix383f3m.Room.fromJson(data) as T;
    }
    if (t == _i14ck3rp.RoomFee) {
      return _i14ck3rp.RoomFee.fromJson(data) as T;
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
    if (t == _isc.getType<_i8gi3061.BookingCategory?>()) {
      return (data != null ? _i8gi3061.BookingCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igo3tr50.BookingCategoryColor?>()) {
      return (data != null
              ? _igo3tr50.BookingCategoryColor.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iso9e2pg.BookingCategoryIcon?>()) {
      return (data != null
              ? _iso9e2pg.BookingCategoryIcon.fromJson(data)
              : null)
          as T;
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
    if (t == _isc.getType<_itj5x341.Household?>()) {
      return (data != null ? _itj5x341.Household.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1si4u4r.HouseholdMember?>()) {
      return (data != null ? _i1si4u4r.HouseholdMember.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iycrigka.Organization?>()) {
      return (data != null ? _iycrigka.Organization.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iggja872.Dashboard?>()) {
      return (data != null ? _iggja872.Dashboard.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9cu7oi7.DashboardStay?>()) {
      return (data != null ? _i9cu7oi7.DashboardStay.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iklsr4n4.ExpiringOption?>()) {
      return (data != null ? _iklsr4n4.ExpiringOption.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igw13nlg.MealBooking?>()) {
      return (data != null ? _igw13nlg.MealBooking.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_il8j3w9m.MealDay?>()) {
      return (data != null ? _il8j3w9m.MealDay.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwoe631f.OpenBalance?>()) {
      return (data != null ? _iwoe631f.OpenBalance.fromJson(data) : null) as T;
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
    if (t == _isc.getType<_i409y09h.AgeGroupCount?>()) {
      return (data != null ? _i409y09h.AgeGroupCount.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i7fy7mhe.DietaryNeed?>()) {
      return (data != null ? _i7fy7mhe.DietaryNeed.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inxh79pp.Guest?>()) {
      return (data != null ? _inxh79pp.Guest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iar0olgw.GuestGroup?>()) {
      return (data != null ? _iar0olgw.GuestGroup.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijaatehs.KitchenOverview?>()) {
      return (data != null ? _ijaatehs.KitchenOverview.fromJson(data) : null)
          as T;
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
    if (t == _isc.getType<_idwz9zuu.FeePrice?>()) {
      return (data != null ? _idwz9zuu.FeePrice.fromJson(data) : null) as T;
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
    if (t == _isc.getType<_iywc4zrq.PriceList?>()) {
      return (data != null ? _iywc4zrq.PriceList.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0r81qjm.PriceListPrices?>()) {
      return (data != null ? _i0r81qjm.PriceListPrices.fromJson(data) : null)
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
    if (t == _isc.getType<_irmv8dws.UnitPrice?>()) {
      return (data != null ? _irmv8dws.UnitPrice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihus81hy.UnitType?>()) {
      return (data != null ? _ihus81hy.UnitType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqh2u036.Building?>()) {
      return (data != null ? _iqh2u036.Building.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ix383f3m.Room?>()) {
      return (data != null ? _ix383f3m.Room.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i14ck3rp.RoomFee?>()) {
      return (data != null ? _i14ck3rp.RoomFee.fromJson(data) : null) as T;
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
    if (t == List<_i1si4u4r.HouseholdMember>) {
      return (data as List)
              .map((e) => deserialize<_i1si4u4r.HouseholdMember>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i1si4u4r.HouseholdMember>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i1si4u4r.HouseholdMember>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i9cu7oi7.DashboardStay>) {
      return (data as List)
              .map((e) => deserialize<_i9cu7oi7.DashboardStay>(e))
              .toList()
          as T;
    }
    if (t == List<_iklsr4n4.ExpiringOption>) {
      return (data as List)
              .map((e) => deserialize<_iklsr4n4.ExpiringOption>(e))
              .toList()
          as T;
    }
    if (t == List<_iwoe631f.OpenBalance>) {
      return (data as List)
              .map((e) => deserialize<_iwoe631f.OpenBalance>(e))
              .toList()
          as T;
    }
    if (t == List<_il8j3w9m.MealDay>) {
      return (data as List)
              .map((e) => deserialize<_il8j3w9m.MealDay>(e))
              .toList()
          as T;
    }
    if (t == List<_i409y09h.AgeGroupCount>) {
      return (data as List)
              .map((e) => deserialize<_i409y09h.AgeGroupCount>(e))
              .toList()
          as T;
    }
    if (t == List<_igw13nlg.MealBooking>) {
      return (data as List)
              .map((e) => deserialize<_igw13nlg.MealBooking>(e))
              .toList()
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
    if (t == List<_i7fy7mhe.DietaryNeed>) {
      return (data as List)
              .map((e) => deserialize<_i7fy7mhe.DietaryNeed>(e))
              .toList()
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
    if (t == List<_i14ck3rp.RoomFee>) {
      return (data as List)
              .map((e) => deserialize<_i14ck3rp.RoomFee>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i14ck3rp.RoomFee>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i14ck3rp.RoomFee>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ivym9zqa.RoomRate>) {
      return (data as List)
              .map((e) => deserialize<_ivym9zqa.RoomRate>(e))
              .toList()
          as T;
    }
    if (t == List<_irmv8dws.UnitPrice>) {
      return (data as List)
              .map((e) => deserialize<_irmv8dws.UnitPrice>(e))
              .toList()
          as T;
    }
    if (t == List<_i79c4x61.MealRate>) {
      return (data as List)
              .map((e) => deserialize<_i79c4x61.MealRate>(e))
              .toList()
          as T;
    }
    if (t == List<_idwz9zuu.FeePrice>) {
      return (data as List)
              .map((e) => deserialize<_idwz9zuu.FeePrice>(e))
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
    if (t == List<_i7p8ds8x.BookingCategory>) {
      return (data as List)
              .map((e) => deserialize<_i7p8ds8x.BookingCategory>(e))
              .toList()
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
    if (t == List<_if2jdwd3.Household>) {
      return (data as List)
              .map((e) => deserialize<_if2jdwd3.Household>(e))
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
    if (t == List<_ivembrbw.PriceList>) {
      return (data as List)
              .map((e) => deserialize<_ivembrbw.PriceList>(e))
              .toList()
          as T;
    }
    if (t == List<_in0tyb01.UnitType>) {
      return (data as List)
              .map((e) => deserialize<_in0tyb01.UnitType>(e))
              .toList()
          as T;
    }
    if (t == List<_iqh700fx.Building>) {
      return (data as List)
              .map((e) => deserialize<_iqh700fx.Building>(e))
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
      _i8gi3061.BookingCategory => 'BookingCategory',
      _igo3tr50.BookingCategoryColor => 'BookingCategoryColor',
      _iso9e2pg.BookingCategoryIcon => 'BookingCategoryIcon',
      _icov2ydl.BookingRoom => 'BookingRoom',
      _iqmkyysz.BookingStatus => 'BookingStatus',
      _iikb94hp.Booking => 'Booking',
      _ij920vmm.ValidationError => 'ValidationError',
      _ifwcmx8g.ValidationException => 'ValidationException',
      _io9atw8a.Contact => 'Contact',
      _itj5x341.Household => 'Household',
      _i1si4u4r.HouseholdMember => 'HouseholdMember',
      _iycrigka.Organization => 'Organization',
      _iggja872.Dashboard => 'Dashboard',
      _i9cu7oi7.DashboardStay => 'DashboardStay',
      _iklsr4n4.ExpiringOption => 'ExpiringOption',
      _igw13nlg.MealBooking => 'MealBooking',
      _il8j3w9m.MealDay => 'MealDay',
      _iwoe631f.OpenBalance => 'OpenBalance',
      _igquyr3v.DonationReceipt => 'DonationReceipt',
      _i80h05fc.Operator => 'Operator',
      _i5pbbm36.ReceiptPreview => 'ReceiptPreview',
      _i3nhuzax.TaxNoticeType => 'TaxNoticeType',
      _izw8z7ou.Greeting => 'Greeting',
      _i409y09h.AgeGroupCount => 'AgeGroupCount',
      _i7fy7mhe.DietaryNeed => 'DietaryNeed',
      _inxh79pp.Guest => 'Guest',
      _iar0olgw.GuestGroup => 'GuestGroup',
      _ijaatehs.KitchenOverview => 'KitchenOverview',
      _igvrv9tv.AgeGroup => 'AgeGroup',
      _i53999gr.BookingPrice => 'BookingPrice',
      _idyrztp6.ChargeLine => 'ChargeLine',
      _iodpb345.ChargeType => 'ChargeType',
      _igatvxgq.Fee => 'Fee',
      _idwz9zuu.FeePrice => 'FeePrice',
      _invqlcyo.FeeUnit => 'FeeUnit',
      _iahrqsj9.MealPlan => 'MealPlan',
      _i79c4x61.MealRate => 'MealRate',
      _iywc4zrq.PriceList => 'PriceList',
      _i0r81qjm.PriceListPrices => 'PriceListPrices',
      _i2s1dsvn.PricingProblem => 'PricingProblem',
      _i0jnw4ju.PricingProblemReason => 'PricingProblemReason',
      _ivym9zqa.RoomRate => 'RoomRate',
      _irmv8dws.UnitPrice => 'UnitPrice',
      _ihus81hy.UnitType => 'UnitType',
      _iqh2u036.Building => 'Building',
      _ix383f3m.Room => 'Room',
      _i14ck3rp.RoomFee => 'RoomFee',
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
      case _i8gi3061.BookingCategory():
        return 'BookingCategory';
      case _igo3tr50.BookingCategoryColor():
        return 'BookingCategoryColor';
      case _iso9e2pg.BookingCategoryIcon():
        return 'BookingCategoryIcon';
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
      case _itj5x341.Household():
        return 'Household';
      case _i1si4u4r.HouseholdMember():
        return 'HouseholdMember';
      case _iycrigka.Organization():
        return 'Organization';
      case _iggja872.Dashboard():
        return 'Dashboard';
      case _i9cu7oi7.DashboardStay():
        return 'DashboardStay';
      case _iklsr4n4.ExpiringOption():
        return 'ExpiringOption';
      case _igw13nlg.MealBooking():
        return 'MealBooking';
      case _il8j3w9m.MealDay():
        return 'MealDay';
      case _iwoe631f.OpenBalance():
        return 'OpenBalance';
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
      case _i409y09h.AgeGroupCount():
        return 'AgeGroupCount';
      case _i7fy7mhe.DietaryNeed():
        return 'DietaryNeed';
      case _inxh79pp.Guest():
        return 'Guest';
      case _iar0olgw.GuestGroup():
        return 'GuestGroup';
      case _ijaatehs.KitchenOverview():
        return 'KitchenOverview';
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
      case _idwz9zuu.FeePrice():
        return 'FeePrice';
      case _invqlcyo.FeeUnit():
        return 'FeeUnit';
      case _iahrqsj9.MealPlan():
        return 'MealPlan';
      case _i79c4x61.MealRate():
        return 'MealRate';
      case _iywc4zrq.PriceList():
        return 'PriceList';
      case _i0r81qjm.PriceListPrices():
        return 'PriceListPrices';
      case _i2s1dsvn.PricingProblem():
        return 'PricingProblem';
      case _i0jnw4ju.PricingProblemReason():
        return 'PricingProblemReason';
      case _ivym9zqa.RoomRate():
        return 'RoomRate';
      case _irmv8dws.UnitPrice():
        return 'UnitPrice';
      case _ihus81hy.UnitType():
        return 'UnitType';
      case _iqh2u036.Building():
        return 'Building';
      case _ix383f3m.Room():
        return 'Room';
      case _i14ck3rp.RoomFee():
        return 'RoomFee';
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
    if (dataClassName == 'BookingCategory') {
      return deserialize<_i8gi3061.BookingCategory>(data['data']);
    }
    if (dataClassName == 'BookingCategoryColor') {
      return deserialize<_igo3tr50.BookingCategoryColor>(data['data']);
    }
    if (dataClassName == 'BookingCategoryIcon') {
      return deserialize<_iso9e2pg.BookingCategoryIcon>(data['data']);
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
    if (dataClassName == 'Household') {
      return deserialize<_itj5x341.Household>(data['data']);
    }
    if (dataClassName == 'HouseholdMember') {
      return deserialize<_i1si4u4r.HouseholdMember>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_iycrigka.Organization>(data['data']);
    }
    if (dataClassName == 'Dashboard') {
      return deserialize<_iggja872.Dashboard>(data['data']);
    }
    if (dataClassName == 'DashboardStay') {
      return deserialize<_i9cu7oi7.DashboardStay>(data['data']);
    }
    if (dataClassName == 'ExpiringOption') {
      return deserialize<_iklsr4n4.ExpiringOption>(data['data']);
    }
    if (dataClassName == 'MealBooking') {
      return deserialize<_igw13nlg.MealBooking>(data['data']);
    }
    if (dataClassName == 'MealDay') {
      return deserialize<_il8j3w9m.MealDay>(data['data']);
    }
    if (dataClassName == 'OpenBalance') {
      return deserialize<_iwoe631f.OpenBalance>(data['data']);
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
    if (dataClassName == 'AgeGroupCount') {
      return deserialize<_i409y09h.AgeGroupCount>(data['data']);
    }
    if (dataClassName == 'DietaryNeed') {
      return deserialize<_i7fy7mhe.DietaryNeed>(data['data']);
    }
    if (dataClassName == 'Guest') {
      return deserialize<_inxh79pp.Guest>(data['data']);
    }
    if (dataClassName == 'GuestGroup') {
      return deserialize<_iar0olgw.GuestGroup>(data['data']);
    }
    if (dataClassName == 'KitchenOverview') {
      return deserialize<_ijaatehs.KitchenOverview>(data['data']);
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
    if (dataClassName == 'FeePrice') {
      return deserialize<_idwz9zuu.FeePrice>(data['data']);
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
    if (dataClassName == 'PriceList') {
      return deserialize<_iywc4zrq.PriceList>(data['data']);
    }
    if (dataClassName == 'PriceListPrices') {
      return deserialize<_i0r81qjm.PriceListPrices>(data['data']);
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
    if (dataClassName == 'UnitPrice') {
      return deserialize<_irmv8dws.UnitPrice>(data['data']);
    }
    if (dataClassName == 'UnitType') {
      return deserialize<_ihus81hy.UnitType>(data['data']);
    }
    if (dataClassName == 'Building') {
      return deserialize<_iqh2u036.Building>(data['data']);
    }
    if (dataClassName == 'Room') {
      return deserialize<_ix383f3m.Room>(data['data']);
    }
    if (dataClassName == 'RoomFee') {
      return deserialize<_i14ck3rp.RoomFee>(data['data']);
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
