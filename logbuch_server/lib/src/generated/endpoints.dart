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
import 'package:logbuch_server/src/generated/auth/user_role.dart' as _ix6woxrf;
import 'package:logbuch_server/src/generated/billing/charge.dart' as _ik0w9o9c;
import 'package:logbuch_server/src/generated/billing/donation.dart'
    as _imjtz2ad;
import 'package:logbuch_server/src/generated/billing/payment.dart' as _ijoeqr7q;
import 'package:logbuch_server/src/generated/bookings/bookings.dart'
    as _iz54m678;
import 'package:logbuch_server/src/generated/contacts/contact.dart'
    as _i4e319y1;
import 'package:logbuch_server/src/generated/contacts/household.dart'
    as _inwmb5da;
import 'package:logbuch_server/src/generated/contacts/organization.dart'
    as _i0zrc0jf;
import 'package:logbuch_server/src/generated/donations/operator.dart'
    as _it92t9k2;
import 'package:logbuch_server/src/generated/guests/guest.dart' as _iju6pcvn;
import 'package:logbuch_server/src/generated/guests/guest_group.dart'
    as _ikiew98c;
import 'package:logbuch_server/src/generated/pricing/age_group.dart'
    as _ifrl6grh;
import 'package:logbuch_server/src/generated/pricing/fee.dart' as _ishmp5re;
import 'package:logbuch_server/src/generated/pricing/meal_plan.dart'
    as _ie35qe72;
import 'package:logbuch_server/src/generated/pricing/meal_rate.dart'
    as _ii7pox79;
import 'package:logbuch_server/src/generated/pricing/price_category.dart'
    as _iqby8hww;
import 'package:logbuch_server/src/generated/pricing/room_rate.dart'
    as _iglzf0wc;
import 'package:logbuch_server/src/generated/pricing/season.dart' as _ityrq9rl;
import 'package:logbuch_server/src/generated/rooms/room.dart' as _iu0pobb2;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../auth/user_endpoint.dart' as _ilyd3rgd;
import '../billing/billing_endpoint.dart' as _irc9lmoc;
import '../bookings/booking_endpoint.dart' as _i7f5j1eo;
import '../contacts/contact_endpoint.dart' as _i468fl3m;
import '../contacts/household_endpoint.dart' as _i2lplksh;
import '../contacts/organization_endpoint.dart' as _i05r4tmt;
import '../dashboard/dashboard_endpoint.dart' as _izwoh05q;
import '../donations/donation_endpoint.dart' as _ipeykwyx;
import '../donations/operator_endpoint.dart' as _ihleekzx;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../guests/guest_endpoint.dart' as _i2qdn6vg;
import '../pricing/age_group_endpoint.dart' as _inglletr;
import '../pricing/fee_endpoint.dart' as _i3umwvkq;
import '../pricing/meal_plan_endpoint.dart' as _i3hv2u2h;
import '../pricing/meal_rate_endpoint.dart' as _ilwr02hf;
import '../pricing/price_category_endpoint.dart' as _ie4qwjfy;
import '../pricing/pricing_endpoint.dart' as _i8epyrd1;
import '../pricing/room_rate_endpoint.dart' as _il118ona;
import '../pricing/season_endpoint.dart' as _ivdu7l1v;
import '../rooms/room_endpoint.dart' as _idkvzxf4;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'user': _ilyd3rgd.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
      'billing': _irc9lmoc.BillingEndpoint()
        ..initialize(
          server,
          'billing',
          null,
        ),
      'booking': _i7f5j1eo.BookingEndpoint()
        ..initialize(
          server,
          'booking',
          null,
        ),
      'contact': _i468fl3m.ContactEndpoint()
        ..initialize(
          server,
          'contact',
          null,
        ),
      'household': _i2lplksh.HouseholdEndpoint()
        ..initialize(
          server,
          'household',
          null,
        ),
      'organization': _i05r4tmt.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'dashboard': _izwoh05q.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'donation': _ipeykwyx.DonationEndpoint()
        ..initialize(
          server,
          'donation',
          null,
        ),
      'operator': _ihleekzx.OperatorEndpoint()
        ..initialize(
          server,
          'operator',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'guest': _i2qdn6vg.GuestEndpoint()
        ..initialize(
          server,
          'guest',
          null,
        ),
      'ageGroup': _inglletr.AgeGroupEndpoint()
        ..initialize(
          server,
          'ageGroup',
          null,
        ),
      'fee': _i3umwvkq.FeeEndpoint()
        ..initialize(
          server,
          'fee',
          null,
        ),
      'mealPlan': _i3hv2u2h.MealPlanEndpoint()
        ..initialize(
          server,
          'mealPlan',
          null,
        ),
      'mealRate': _ilwr02hf.MealRateEndpoint()
        ..initialize(
          server,
          'mealRate',
          null,
        ),
      'priceCategory': _ie4qwjfy.PriceCategoryEndpoint()
        ..initialize(
          server,
          'priceCategory',
          null,
        ),
      'pricing': _i8epyrd1.PricingEndpoint()
        ..initialize(
          server,
          'pricing',
          null,
        ),
      'roomRate': _il118ona.RoomRateEndpoint()
        ..initialize(
          server,
          'roomRate',
          null,
        ),
      'season': _ivdu7l1v.SeasonEndpoint()
        ..initialize(
          server,
          'season',
          null,
        ),
      'room': _idkvzxf4.RoomEndpoint()
        ..initialize(
          server,
          'room',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['user'] = _is.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _ilyd3rgd.UserEndpoint).me(session),
        ),
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _ilyd3rgd.UserEndpoint).getAll(session),
        ),
        'setRole': _is.MethodConnector(
          name: 'setRole',
          params: {
            'authUserId': _is.ParameterDescription(
              name: 'authUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_ix6woxrf.UserRole?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _ilyd3rgd.UserEndpoint).setRole(
                session,
                params['authUserId'],
                params['role'],
              ),
        ),
      },
    );
    connectors['billing'] = _is.EndpointConnector(
      name: 'billing',
      endpoint: endpoints['billing']!,
      methodConnectors: {
        'getFolios': _is.MethodConnector(
          name: 'getFolios',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['billing'] as _irc9lmoc.BillingEndpoint).getFolios(
                    session,
                    params['bookingId'],
                  ),
        ),
        'addCharge': _is.MethodConnector(
          name: 'addCharge',
          params: {
            'charge': _is.ParameterDescription(
              name: 'charge',
              type: _is.getType<_ik0w9o9c.Charge>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['billing'] as _irc9lmoc.BillingEndpoint).addCharge(
                    session,
                    params['charge'],
                  ),
        ),
        'deleteCharge': _is.MethodConnector(
          name: 'deleteCharge',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['billing'] as _irc9lmoc.BillingEndpoint)
                  .deleteCharge(
                    session,
                    params['id'],
                  ),
        ),
        'invoice': _is.MethodConnector(
          name: 'invoice',
          params: {
            'folioId': _is.ParameterDescription(
              name: 'folioId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['billing'] as _irc9lmoc.BillingEndpoint).invoice(
                    session,
                    params['folioId'],
                  ),
        ),
        'getInvoicePdf': _is.MethodConnector(
          name: 'getInvoicePdf',
          params: {
            'folioId': _is.ParameterDescription(
              name: 'folioId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['billing'] as _irc9lmoc.BillingEndpoint)
                  .getInvoicePdf(
                    session,
                    params['folioId'],
                  ),
        ),
        'renewInvoicePdf': _is.MethodConnector(
          name: 'renewInvoicePdf',
          params: {
            'folioId': _is.ParameterDescription(
              name: 'folioId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['billing'] as _irc9lmoc.BillingEndpoint)
                  .renewInvoicePdf(
                    session,
                    params['folioId'],
                  ),
        ),
        'addPayment': _is.MethodConnector(
          name: 'addPayment',
          params: {
            'payment': _is.ParameterDescription(
              name: 'payment',
              type: _is.getType<_ijoeqr7q.Payment>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['billing'] as _irc9lmoc.BillingEndpoint)
                  .addPayment(
                    session,
                    params['payment'],
                  ),
        ),
        'deletePayment': _is.MethodConnector(
          name: 'deletePayment',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['billing'] as _irc9lmoc.BillingEndpoint)
                  .deletePayment(
                    session,
                    params['id'],
                  ),
        ),
        'donate': _is.MethodConnector(
          name: 'donate',
          params: {
            'paymentId': _is.ParameterDescription(
              name: 'paymentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'amount': _is.ParameterDescription(
              name: 'amount',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['billing'] as _irc9lmoc.BillingEndpoint).donate(
                    session,
                    params['paymentId'],
                    params['amount'],
                  ),
        ),
        'deleteDonation': _is.MethodConnector(
          name: 'deleteDonation',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['billing'] as _irc9lmoc.BillingEndpoint)
                  .deleteDonation(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['booking'] = _is.EndpointConnector(
      name: 'booking',
      endpoint: endpoints['booking']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _i7f5j1eo.BookingEndpoint)
                  .getAll(session),
        ),
        'getById': _is.MethodConnector(
          name: 'getById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _i7f5j1eo.BookingEndpoint).getById(
                    session,
                    params['id'],
                  ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'booking': _is.ParameterDescription(
              name: 'booking',
              type: _is.getType<_iz54m678.Booking>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _i7f5j1eo.BookingEndpoint).add(
                    session,
                    params['booking'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'booking': _is.ParameterDescription(
              name: 'booking',
              type: _is.getType<_iz54m678.Booking>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _i7f5j1eo.BookingEndpoint).update(
                    session,
                    params['booking'],
                  ),
        ),
        'getConfirmationPdf': _is.MethodConnector(
          name: 'getConfirmationPdf',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _i7f5j1eo.BookingEndpoint)
                  .getConfirmationPdf(
                    session,
                    params['bookingId'],
                  ),
        ),
        'availableRooms': _is.MethodConnector(
          name: 'availableRooms',
          params: {
            'arrival': _is.ParameterDescription(
              name: 'arrival',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'departure': _is.ParameterDescription(
              name: 'departure',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'exceptBookingId': _is.ParameterDescription(
              name: 'exceptBookingId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _i7f5j1eo.BookingEndpoint)
                  .availableRooms(
                    session,
                    params['arrival'],
                    params['departure'],
                    exceptBookingId: params['exceptBookingId'],
                  ),
        ),
        'setRooms': _is.MethodConnector(
          name: 'setRooms',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'roomIds': _is.ParameterDescription(
              name: 'roomIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['booking'] as _i7f5j1eo.BookingEndpoint).setRooms(
                    session,
                    params['bookingId'],
                    params['roomIds'],
                  ),
        ),
      },
    );
    connectors['contact'] = _is.EndpointConnector(
      name: 'contact',
      endpoint: endpoints['contact']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['contact'] as _i468fl3m.ContactEndpoint)
                  .getAll(session),
        ),
        'getById': _is.MethodConnector(
          name: 'getById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['contact'] as _i468fl3m.ContactEndpoint).getById(
                    session,
                    params['id'],
                  ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'contact': _is.ParameterDescription(
              name: 'contact',
              type: _is.getType<_i4e319y1.Contact>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['contact'] as _i468fl3m.ContactEndpoint).add(
                    session,
                    params['contact'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'contact': _is.ParameterDescription(
              name: 'contact',
              type: _is.getType<_i4e319y1.Contact>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['contact'] as _i468fl3m.ContactEndpoint).update(
                    session,
                    params['contact'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['contact'] as _i468fl3m.ContactEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['household'] = _is.EndpointConnector(
      name: 'household',
      endpoint: endpoints['household']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _i2lplksh.HouseholdEndpoint)
                  .getAll(session),
        ),
        'save': _is.MethodConnector(
          name: 'save',
          params: {
            'household': _is.ParameterDescription(
              name: 'household',
              type: _is.getType<_inwmb5da.Household>(),
              nullable: false,
            ),
            'memberIds': _is.ParameterDescription(
              name: 'memberIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['household'] as _i2lplksh.HouseholdEndpoint).save(
                    session,
                    params['household'],
                    params['memberIds'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['household'] as _i2lplksh.HouseholdEndpoint)
                  .delete(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['organization'] = _is.EndpointConnector(
      name: 'organization',
      endpoint: endpoints['organization']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i05r4tmt.OrganizationEndpoint)
                      .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'organization': _is.ParameterDescription(
              name: 'organization',
              type: _is.getType<_i0zrc0jf.Organization>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i05r4tmt.OrganizationEndpoint)
                      .add(
                        session,
                        params['organization'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'organization': _is.ParameterDescription(
              name: 'organization',
              type: _is.getType<_i0zrc0jf.Organization>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i05r4tmt.OrganizationEndpoint)
                      .update(
                        session,
                        params['organization'],
                      ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organization'] as _i05r4tmt.OrganizationEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['dashboard'] = _is.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'load': _is.MethodConnector(
          name: 'load',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _izwoh05q.DashboardEndpoint)
                  .load(session),
        ),
      },
    );
    connectors['donation'] = _is.EndpointConnector(
      name: 'donation',
      endpoint: endpoints['donation']!,
      methodConnectors: {
        'getByYear': _is.MethodConnector(
          name: 'getByYear',
          params: {
            'year': _is.ParameterDescription(
              name: 'year',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donation'] as _ipeykwyx.DonationEndpoint)
                  .getByYear(
                    session,
                    params['year'],
                  ),
        ),
        'addDirect': _is.MethodConnector(
          name: 'addDirect',
          params: {
            'donation': _is.ParameterDescription(
              name: 'donation',
              type: _is.getType<_imjtz2ad.Donation>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donation'] as _ipeykwyx.DonationEndpoint)
                  .addDirect(
                    session,
                    params['donation'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['donation'] as _ipeykwyx.DonationEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
        'previewReceipts': _is.MethodConnector(
          name: 'previewReceipts',
          params: {
            'year': _is.ParameterDescription(
              name: 'year',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donation'] as _ipeykwyx.DonationEndpoint)
                  .previewReceipts(
                    session,
                    params['year'],
                  ),
        ),
        'createReceipts': _is.MethodConnector(
          name: 'createReceipts',
          params: {
            'year': _is.ParameterDescription(
              name: 'year',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donation'] as _ipeykwyx.DonationEndpoint)
                  .createReceipts(
                    session,
                    params['year'],
                  ),
        ),
        'getReceipts': _is.MethodConnector(
          name: 'getReceipts',
          params: {
            'year': _is.ParameterDescription(
              name: 'year',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donation'] as _ipeykwyx.DonationEndpoint)
                  .getReceipts(
                    session,
                    params['year'],
                  ),
        ),
        'getReceiptPdf': _is.MethodConnector(
          name: 'getReceiptPdf',
          params: {
            'receiptId': _is.ParameterDescription(
              name: 'receiptId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donation'] as _ipeykwyx.DonationEndpoint)
                  .getReceiptPdf(
                    session,
                    params['receiptId'],
                  ),
        ),
      },
    );
    connectors['operator'] = _is.EndpointConnector(
      name: 'operator',
      endpoint: endpoints['operator']!,
      methodConnectors: {
        'load': _is.MethodConnector(
          name: 'load',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operator'] as _ihleekzx.OperatorEndpoint)
                  .load(session),
        ),
        'save': _is.MethodConnector(
          name: 'save',
          params: {
            'operator': _is.ParameterDescription(
              name: 'operator',
              type: _is.getType<_it92t9k2.Operator>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['operator'] as _ihleekzx.OperatorEndpoint).save(
                    session,
                    params['operator'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['guest'] = _is.EndpointConnector(
      name: 'guest',
      endpoint: endpoints['guest']!,
      methodConnectors: {
        'getByBooking': _is.MethodConnector(
          name: 'getByBooking',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).getByBooking(
                    session,
                    params['bookingId'],
                  ),
        ),
        'kitchenOverview': _is.MethodConnector(
          name: 'kitchenOverview',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guest'] as _i2qdn6vg.GuestEndpoint)
                  .kitchenOverview(
                    session,
                    params['bookingId'],
                  ),
        ),
        'addHousehold': _is.MethodConnector(
          name: 'addHousehold',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'householdId': _is.ParameterDescription(
              name: 'householdId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).addHousehold(
                    session,
                    params['bookingId'],
                    params['householdId'],
                  ),
        ),
        'addGroup': _is.MethodConnector(
          name: 'addGroup',
          params: {
            'group': _is.ParameterDescription(
              name: 'group',
              type: _is.getType<_ikiew98c.GuestGroup>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).addGroup(
                    session,
                    params['group'],
                  ),
        ),
        'updateGroup': _is.MethodConnector(
          name: 'updateGroup',
          params: {
            'group': _is.ParameterDescription(
              name: 'group',
              type: _is.getType<_ikiew98c.GuestGroup>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).updateGroup(
                    session,
                    params['group'],
                  ),
        ),
        'deleteGroup': _is.MethodConnector(
          name: 'deleteGroup',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).deleteGroup(
                    session,
                    params['id'],
                  ),
        ),
        'addGuest': _is.MethodConnector(
          name: 'addGuest',
          params: {
            'guest': _is.ParameterDescription(
              name: 'guest',
              type: _is.getType<_iju6pcvn.Guest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).addGuest(
                    session,
                    params['guest'],
                  ),
        ),
        'addNewGuest': _is.MethodConnector(
          name: 'addNewGuest',
          params: {
            'guest': _is.ParameterDescription(
              name: 'guest',
              type: _is.getType<_iju6pcvn.Guest>(),
              nullable: false,
            ),
            'contact': _is.ParameterDescription(
              name: 'contact',
              type: _is.getType<_i4e319y1.Contact>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).addNewGuest(
                    session,
                    params['guest'],
                    params['contact'],
                  ),
        ),
        'updateGuest': _is.MethodConnector(
          name: 'updateGuest',
          params: {
            'guest': _is.ParameterDescription(
              name: 'guest',
              type: _is.getType<_iju6pcvn.Guest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).updateGuest(
                    session,
                    params['guest'],
                  ),
        ),
        'deleteGuest': _is.MethodConnector(
          name: 'deleteGuest',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).deleteGuest(
                    session,
                    params['id'],
                  ),
        ),
        'assign': _is.MethodConnector(
          name: 'assign',
          params: {
            'guestIds': _is.ParameterDescription(
              name: 'guestIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
            'bookingRoomId': _is.ParameterDescription(
              name: 'bookingRoomId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guest'] as _i2qdn6vg.GuestEndpoint).assign(
                session,
                params['guestIds'],
                params['bookingRoomId'],
              ),
        ),
      },
    );
    connectors['ageGroup'] = _is.EndpointConnector(
      name: 'ageGroup',
      endpoint: endpoints['ageGroup']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ageGroup'] as _inglletr.AgeGroupEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'group': _is.ParameterDescription(
              name: 'group',
              type: _is.getType<_ifrl6grh.AgeGroup>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ageGroup'] as _inglletr.AgeGroupEndpoint).add(
                    session,
                    params['group'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'group': _is.ParameterDescription(
              name: 'group',
              type: _is.getType<_ifrl6grh.AgeGroup>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ageGroup'] as _inglletr.AgeGroupEndpoint).update(
                    session,
                    params['group'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ageGroup'] as _inglletr.AgeGroupEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['fee'] = _is.EndpointConnector(
      name: 'fee',
      endpoint: endpoints['fee']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['fee'] as _i3umwvkq.FeeEndpoint).getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'fee': _is.ParameterDescription(
              name: 'fee',
              type: _is.getType<_ishmp5re.Fee>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['fee'] as _i3umwvkq.FeeEndpoint).add(
                session,
                params['fee'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'fee': _is.ParameterDescription(
              name: 'fee',
              type: _is.getType<_ishmp5re.Fee>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['fee'] as _i3umwvkq.FeeEndpoint).update(
                session,
                params['fee'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['fee'] as _i3umwvkq.FeeEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['mealPlan'] = _is.EndpointConnector(
      name: 'mealPlan',
      endpoint: endpoints['mealPlan']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mealPlan'] as _i3hv2u2h.MealPlanEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'plan': _is.ParameterDescription(
              name: 'plan',
              type: _is.getType<_ie35qe72.MealPlan>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mealPlan'] as _i3hv2u2h.MealPlanEndpoint).add(
                    session,
                    params['plan'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'plan': _is.ParameterDescription(
              name: 'plan',
              type: _is.getType<_ie35qe72.MealPlan>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mealPlan'] as _i3hv2u2h.MealPlanEndpoint).update(
                    session,
                    params['plan'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['mealPlan'] as _i3hv2u2h.MealPlanEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['mealRate'] = _is.EndpointConnector(
      name: 'mealRate',
      endpoint: endpoints['mealRate']!,
      methodConnectors: {
        'getBySeason': _is.MethodConnector(
          name: 'getBySeason',
          params: {
            'seasonId': _is.ParameterDescription(
              name: 'seasonId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mealRate'] as _ilwr02hf.MealRateEndpoint)
                  .getBySeason(
                    session,
                    params['seasonId'],
                  ),
        ),
        'saveForSeason': _is.MethodConnector(
          name: 'saveForSeason',
          params: {
            'seasonId': _is.ParameterDescription(
              name: 'seasonId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'rates': _is.ParameterDescription(
              name: 'rates',
              type: _is.getType<List<_ii7pox79.MealRate>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mealRate'] as _ilwr02hf.MealRateEndpoint)
                  .saveForSeason(
                    session,
                    params['seasonId'],
                    params['rates'],
                  ),
        ),
      },
    );
    connectors['priceCategory'] = _is.EndpointConnector(
      name: 'priceCategory',
      endpoint: endpoints['priceCategory']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['priceCategory']
                          as _ie4qwjfy.PriceCategoryEndpoint)
                      .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<_iqby8hww.PriceCategory>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['priceCategory']
                          as _ie4qwjfy.PriceCategoryEndpoint)
                      .add(
                        session,
                        params['category'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<_iqby8hww.PriceCategory>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['priceCategory']
                          as _ie4qwjfy.PriceCategoryEndpoint)
                      .update(
                        session,
                        params['category'],
                      ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['priceCategory']
                          as _ie4qwjfy.PriceCategoryEndpoint)
                      .delete(
                        session,
                        params['id'],
                      ),
        ),
      },
    );
    connectors['pricing'] = _is.EndpointConnector(
      name: 'pricing',
      endpoint: endpoints['pricing']!,
      methodConnectors: {
        'calculate': _is.MethodConnector(
          name: 'calculate',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['pricing'] as _i8epyrd1.PricingEndpoint).calculate(
                    session,
                    params['bookingId'],
                  ),
        ),
      },
    );
    connectors['roomRate'] = _is.EndpointConnector(
      name: 'roomRate',
      endpoint: endpoints['roomRate']!,
      methodConnectors: {
        'getBySeason': _is.MethodConnector(
          name: 'getBySeason',
          params: {
            'seasonId': _is.ParameterDescription(
              name: 'seasonId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['roomRate'] as _il118ona.RoomRateEndpoint)
                  .getBySeason(
                    session,
                    params['seasonId'],
                  ),
        ),
        'saveForSeason': _is.MethodConnector(
          name: 'saveForSeason',
          params: {
            'seasonId': _is.ParameterDescription(
              name: 'seasonId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'rates': _is.ParameterDescription(
              name: 'rates',
              type: _is.getType<List<_iglzf0wc.RoomRate>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['roomRate'] as _il118ona.RoomRateEndpoint)
                  .saveForSeason(
                    session,
                    params['seasonId'],
                    params['rates'],
                  ),
        ),
      },
    );
    connectors['season'] = _is.EndpointConnector(
      name: 'season',
      endpoint: endpoints['season']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['season'] as _ivdu7l1v.SeasonEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'season': _is.ParameterDescription(
              name: 'season',
              type: _is.getType<_ityrq9rl.Season>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['season'] as _ivdu7l1v.SeasonEndpoint).add(
                session,
                params['season'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'season': _is.ParameterDescription(
              name: 'season',
              type: _is.getType<_ityrq9rl.Season>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['season'] as _ivdu7l1v.SeasonEndpoint).update(
                    session,
                    params['season'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['season'] as _ivdu7l1v.SeasonEndpoint).delete(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['room'] = _is.EndpointConnector(
      name: 'room',
      endpoint: endpoints['room']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['room'] as _idkvzxf4.RoomEndpoint).getAll(session),
        ),
        'getById': _is.MethodConnector(
          name: 'getById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _idkvzxf4.RoomEndpoint).getById(
                session,
                params['id'],
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<_iu0pobb2.Room>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _idkvzxf4.RoomEndpoint).add(
                session,
                params['room'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'room': _is.ParameterDescription(
              name: 'room',
              type: _is.getType<_iu0pobb2.Room>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _idkvzxf4.RoomEndpoint).update(
                session,
                params['room'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['room'] as _idkvzxf4.RoomEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
