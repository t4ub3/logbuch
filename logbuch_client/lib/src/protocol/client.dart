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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:logbuch_client/src/protocol/auth/app_user.dart' as _il34w39i;
import 'package:logbuch_client/src/protocol/auth/user_role.dart' as _iesc6ap1;
import 'package:logbuch_client/src/protocol/billing/charge.dart' as _is60kra1;
import 'package:logbuch_client/src/protocol/billing/donation.dart' as _ibol987g;
import 'package:logbuch_client/src/protocol/billing/folio.dart' as _in6c8fr8;
import 'package:logbuch_client/src/protocol/billing/payment.dart' as _iwxc7te6;
import 'package:logbuch_client/src/protocol/bookings/bookings.dart'
    as _iey0gn1f;
import 'package:logbuch_client/src/protocol/contacts/contact.dart' as _izv2jndr;
import 'package:logbuch_client/src/protocol/contacts/household.dart'
    as _if2jdwd3;
import 'package:logbuch_client/src/protocol/contacts/organization.dart'
    as _igjrrozn;
import 'package:logbuch_client/src/protocol/dashboard/dashboard.dart'
    as _ixsk8ltj;
import 'package:logbuch_client/src/protocol/donations/donation_receipt.dart'
    as _i8cfzthc;
import 'package:logbuch_client/src/protocol/donations/operator.dart'
    as _i6bqazya;
import 'package:logbuch_client/src/protocol/donations/receipt_preview.dart'
    as _imgf7vt5;
import 'package:logbuch_client/src/protocol/greetings/greeting.dart'
    as _ij8ru2br;
import 'package:logbuch_client/src/protocol/guests/guest.dart' as _i44zmmsa;
import 'package:logbuch_client/src/protocol/guests/guest_group.dart'
    as _ihpk2u4j;
import 'package:logbuch_client/src/protocol/guests/kitchen_overview.dart'
    as _igu8r4n7;
import 'package:logbuch_client/src/protocol/pricing/age_group.dart'
    as _iw3hbj1z;
import 'package:logbuch_client/src/protocol/pricing/booking_price.dart'
    as _iti0hbb0;
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
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// An endpoint of the app. All of its calls need a signed-in user with a
/// role. Methods that change data call [requireAdmin] first.
/// {@category Endpoint}
abstract class EndpointApp extends _isc.EndpointRef {
  EndpointApp(_isc.EndpointCaller caller) : super(caller);
}

/// The users of the app and their roles. Unlike the other endpoints it can
/// be called without a role, so that new users can see that they have none.
/// {@category Endpoint}
class EndpointUser extends _isc.EndpointRef {
  EndpointUser(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// The signed-in user.
  _ida.Future<_il34w39i.AppUser> me() =>
      caller.callServerEndpoint<_il34w39i.AppUser>(
        'user',
        'me',
        {},
      );

  _ida.Future<List<_il34w39i.AppUser>> getAll() =>
      caller.callServerEndpoint<List<_il34w39i.AppUser>>(
        'user',
        'getAll',
        {},
      );

  /// Gives the user a [role], or takes it away with null. Admins cannot
  /// change their own role, so there is always one left.
  _ida.Future<_il34w39i.AppUser> setRole(
    _isc.UuidValue authUserId,
    _iesc6ap1.UserRole? role,
  ) => caller.callServerEndpoint<_il34w39i.AppUser>(
    'user',
    'setRole',
    {
      'authUserId': authUserId,
      'role': role,
    },
  );
}

/// The folios of a booking: what each payer is charged, what they paid and
/// what they donated.
/// {@category Endpoint}
class EndpointBilling extends EndpointApp {
  EndpointBilling(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'billing';

  /// The folios of the booking with their charges, their payments and the
  /// donations made with those.
  ///
  /// The charges of folios that are not invoiced yet are brought in line
  /// with the booking and the current rates first, so they always reflect
  /// its guests, rooms and billing mode. An invoiced folio stays as it was
  /// invoiced.
  _ida.Future<List<_in6c8fr8.Folio>> getFolios(int bookingId) =>
      caller.callServerEndpoint<List<_in6c8fr8.Folio>>(
        'billing',
        'getFolios',
        {'bookingId': bookingId},
      );

  /// Adds a charge by hand to a folio that is not invoiced yet: something
  /// extra, or a discount with a negative price.
  _ida.Future<_is60kra1.Charge> addCharge(_is60kra1.Charge charge) =>
      caller.callServerEndpoint<_is60kra1.Charge>(
        'billing',
        'addCharge',
        {'charge': charge},
      );

  /// Removes a charge that was added by hand, while its folio is not
  /// invoiced yet.
  _ida.Future<void> deleteCharge(int id) => caller.callServerEndpoint<void>(
    'billing',
    'deleteCharge',
    {'id': id},
  );

  /// Turns the folio into an invoice: it gets the next invoice number of the
  /// year and its charges stay as they are from now on.
  ///
  /// Fails while a part of the booking cannot be priced, so that nothing is
  /// missing on an invoice.
  _ida.Future<_in6c8fr8.Folio> invoice(int folioId) =>
      caller.callServerEndpoint<_in6c8fr8.Folio>(
        'billing',
        'invoice',
        {'folioId': folioId},
      );

  /// The invoice of an invoiced folio as a PDF.
  ///
  /// It is produced when it is first asked for and kept as it is from then
  /// on, so that an invoice that was sent out does not change when the
  /// details of the operator or the address of the payer do.
  _ida.Future<_idt.ByteData> getInvoicePdf(int folioId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'billing',
        'getInvoicePdf',
        {'folioId': folioId},
      );

  /// Produces the invoice anew from the details as they are now and keeps
  /// that in place of the stored document.
  ///
  /// Meant for an invoice that was not sent out yet, for example because the
  /// bank details were only entered after it was first opened.
  _ida.Future<_idt.ByteData> renewInvoicePdf(int folioId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'billing',
        'renewInvoicePdf',
        {'folioId': folioId},
      );

  /// Records money received for a folio. A negative amount is a refund.
  _ida.Future<_iwxc7te6.Payment> addPayment(_iwxc7te6.Payment payment) =>
      caller.callServerEndpoint<_iwxc7te6.Payment>(
        'billing',
        'addPayment',
        {'payment': payment},
      );

  /// Removes a payment that was recorded by mistake. A payment that a
  /// donation was made with stays until the donation is removed.
  _ida.Future<void> deletePayment(int id) => caller.callServerEndpoint<void>(
    'billing',
    'deletePayment',
    {'id': id},
  );

  /// Records that the payer leaves [amount] of what they overpaid with the
  /// payment as a donation.
  ///
  /// This is only called when the payer said so. A donation has to be
  /// voluntary to count as one, so overpaid money never becomes a donation
  /// by itself.
  _ida.Future<_ibol987g.Donation> donate(
    int paymentId,
    int amount,
  ) => caller.callServerEndpoint<_ibol987g.Donation>(
    'billing',
    'donate',
    {
      'paymentId': paymentId,
      'amount': amount,
    },
  );

  /// Takes back a donation; the money counts as overpaid again. A
  /// donation that is on a receipt stays.
  _ida.Future<void> deleteDonation(int id) => caller.callServerEndpoint<void>(
    'billing',
    'deleteDonation',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointBooking extends EndpointApp {
  EndpointBooking(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'booking';

  _ida.Future<List<_iey0gn1f.Booking>> getAll() =>
      caller.callServerEndpoint<List<_iey0gn1f.Booking>>(
        'booking',
        'getAll',
        {},
      );

  _ida.Future<_iey0gn1f.Booking?> getById(int id) =>
      caller.callServerEndpoint<_iey0gn1f.Booking?>(
        'booking',
        'getById',
        {'id': id},
      );

  /// Creates a booking without rooms; those are set with [setRooms].
  _ida.Future<_iey0gn1f.Booking> add(_iey0gn1f.Booking booking) =>
      caller.callServerEndpoint<_iey0gn1f.Booking>(
        'booking',
        'add',
        {'booking': booking},
      );

  /// Updates a booking. The rooms it holds must also be free for its new
  /// dates and status. Who is billed cannot change anymore once one of
  /// its folios is invoiced.
  _ida.Future<_iey0gn1f.Booking> update(_iey0gn1f.Booking booking) =>
      caller.callServerEndpoint<_iey0gn1f.Booking>(
        'booking',
        'update',
        {'booking': booking},
      );

  /// The confirmation of the booking for its lead, as a PDF.
  ///
  /// It is made anew every time from the booking as it is now, with the
  /// date of today, and is not kept. The price is only on it while all of
  /// the booking can be priced.
  _ida.Future<_idt.ByteData> getConfirmationPdf(int bookingId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'booking',
        'getConfirmationPdf',
        {'bookingId': bookingId},
      );

  /// The active rooms that no booking holds during the nights from [arrival]
  /// to [departure]. The rooms of [exceptBookingId] count as free, so that
  /// the booking can keep them.
  _ida.Future<List<_i5smwbna.Room>> availableRooms(
    DateTime arrival,
    DateTime departure, {
    int? exceptBookingId,
  }) => caller.callServerEndpoint<List<_i5smwbna.Room>>(
    'booking',
    'availableRooms',
    {
      'arrival': arrival,
      'departure': departure,
      'exceptBookingId': exceptBookingId,
    },
  );

  /// Replaces the rooms that the booking holds. Fails if one of them is
  /// held by another booking during its nights.
  _ida.Future<_iey0gn1f.Booking> setRooms(
    int bookingId,
    List<int> roomIds,
  ) => caller.callServerEndpoint<_iey0gn1f.Booking>(
    'booking',
    'setRooms',
    {
      'bookingId': bookingId,
      'roomIds': roomIds,
    },
  );
}

/// {@category Endpoint}
class EndpointContact extends EndpointApp {
  EndpointContact(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'contact';

  _ida.Future<List<_izv2jndr.Contact>> getAll() =>
      caller.callServerEndpoint<List<_izv2jndr.Contact>>(
        'contact',
        'getAll',
        {},
      );

  _ida.Future<_izv2jndr.Contact?> getById(int id) =>
      caller.callServerEndpoint<_izv2jndr.Contact?>(
        'contact',
        'getById',
        {'id': id},
      );

  _ida.Future<_izv2jndr.Contact> add(_izv2jndr.Contact contact) =>
      caller.callServerEndpoint<_izv2jndr.Contact>(
        'contact',
        'add',
        {'contact': contact},
      );

  _ida.Future<_izv2jndr.Contact> update(_izv2jndr.Contact contact) =>
      caller.callServerEndpoint<_izv2jndr.Contact>(
        'contact',
        'update',
        {'contact': contact},
      );

  /// A contact that leads a booking, is a guest of one, pays for one or
  /// made a donation cannot be deleted.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'contact',
    'delete',
    {'id': id},
  );
}

/// Households: contacts who usually travel together, such as a family.
/// {@category Endpoint}
class EndpointHousehold extends EndpointApp {
  EndpointHousehold(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'household';

  /// All households with their members and the contacts of those.
  _ida.Future<List<_if2jdwd3.Household>> getAll() =>
      caller.callServerEndpoint<List<_if2jdwd3.Household>>(
        'household',
        'getAll',
        {},
      );

  /// Stores the household, new or changed, with the contacts in [memberIds]
  /// as its members. Contacts that are left out are no longer members.
  _ida.Future<_if2jdwd3.Household> save(
    _if2jdwd3.Household household,
    List<int> memberIds,
  ) => caller.callServerEndpoint<_if2jdwd3.Household>(
    'household',
    'save',
    {
      'household': household,
      'memberIds': memberIds,
    },
  );

  /// Removes the household. Its members stay as contacts.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'household',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointOrganization extends EndpointApp {
  EndpointOrganization(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  _ida.Future<List<_igjrrozn.Organization>> getAll() =>
      caller.callServerEndpoint<List<_igjrrozn.Organization>>(
        'organization',
        'getAll',
        {},
      );

  _ida.Future<_igjrrozn.Organization> add(
    _igjrrozn.Organization organization,
  ) => caller.callServerEndpoint<_igjrrozn.Organization>(
    'organization',
    'add',
    {'organization': organization},
  );

  _ida.Future<_igjrrozn.Organization> update(
    _igjrrozn.Organization organization,
  ) => caller.callServerEndpoint<_igjrrozn.Organization>(
    'organization',
    'update',
    {'organization': organization},
  );

  /// The contacts of the organization stay, without an organization. An
  /// organization that a booking belongs to cannot be deleted.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'organization',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointDashboard extends EndpointApp {
  EndpointDashboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// What the start screen shows about today and the days ahead, see
  /// [buildDashboard].
  _ida.Future<_ixsk8ltj.Dashboard> load() =>
      caller.callServerEndpoint<_ixsk8ltj.Dashboard>(
        'dashboard',
        'load',
        {},
      );
}

/// Donations and the yearly receipts for them.
/// {@category Endpoint}
class EndpointDonation extends EndpointApp {
  EndpointDonation(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'donation';

  /// The donations made in [year], with their donors and receipts.
  _ida.Future<List<_ibol987g.Donation>> getByYear(int year) =>
      caller.callServerEndpoint<List<_ibol987g.Donation>>(
        'donation',
        'getByYear',
        {'year': year},
      );

  /// Records a donation that was not left over from a payment.
  _ida.Future<_ibol987g.Donation> addDirect(_ibol987g.Donation donation) =>
      caller.callServerEndpoint<_ibol987g.Donation>(
        'donation',
        'addDirect',
        {'donation': donation},
      );

  /// Removes a donation that was recorded with [addDirect], unless it is on
  /// a receipt. A donation from a payment is taken back in its booking.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'donation',
    'delete',
    {'id': id},
  );

  /// The receipts that [createReceipts] would issue for [year]: one per
  /// donor with donations that are on no receipt yet.
  _ida.Future<List<_imgf7vt5.ReceiptPreview>> previewReceipts(int year) =>
      caller.callServerEndpoint<List<_imgf7vt5.ReceiptPreview>>(
        'donation',
        'previewReceipts',
        {'year': year},
      );

  /// Issues a receipt to every donor for their donations of [year] that are
  /// on no receipt yet, and returns the new receipts.
  ///
  /// A donor without a full address gets none until the address is there,
  /// as a receipt has to state it. From now on the donations of a receipt
  /// cannot change.
  _ida.Future<List<_i8cfzthc.DonationReceipt>> createReceipts(int year) =>
      caller.callServerEndpoint<List<_i8cfzthc.DonationReceipt>>(
        'donation',
        'createReceipts',
        {'year': year},
      );

  /// The receipts issued for [year], without their documents.
  _ida.Future<List<_i8cfzthc.DonationReceipt>> getReceipts(int year) =>
      caller.callServerEndpoint<List<_i8cfzthc.DonationReceipt>>(
        'donation',
        'getReceipts',
        {'year': year},
      );

  /// The document of a receipt as it was issued, a PDF.
  _ida.Future<_idt.ByteData> getReceiptPdf(int receiptId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'donation',
        'getReceiptPdf',
        {'receiptId': receiptId},
      );
}

/// The details of the organisation that runs the house. There is one set of
/// them per installation.
/// {@category Endpoint}
class EndpointOperator extends EndpointApp {
  EndpointOperator(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'operator';

  /// The details, or null if none were entered yet.
  _ida.Future<_i6bqazya.Operator?> load() =>
      caller.callServerEndpoint<_i6bqazya.Operator?>(
        'operator',
        'load',
        {},
      );

  _ida.Future<_i6bqazya.Operator> save(_i6bqazya.Operator operator) =>
      caller.callServerEndpoint<_i6bqazya.Operator>(
        'operator',
        'save',
        {'operator': operator},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ij8ru2br.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ij8ru2br.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// The guests of a booking, in groups such as families.
/// {@category Endpoint}
class EndpointGuest extends EndpointApp {
  EndpointGuest(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'guest';

  /// The groups of the booking with their guests and the contacts of those.
  _ida.Future<List<_ihpk2u4j.GuestGroup>> getByBooking(int bookingId) =>
      caller.callServerEndpoint<List<_ihpk2u4j.GuestGroup>>(
        'guest',
        'getByBooking',
        {'bookingId': bookingId},
      );

  /// The guests of the booking summed up for the kitchen: how many there
  /// are in every age group, and their dietary needs.
  _ida.Future<_igu8r4n7.KitchenOverview> kitchenOverview(int bookingId) =>
      caller.callServerEndpoint<_igu8r4n7.KitchenOverview>(
        'guest',
        'kitchenOverview',
        {'bookingId': bookingId},
      );

  /// Adds the members of a household to the booking, as a new group named
  /// after the household. Members who are guests of the booking already are
  /// left out, so that nobody is there twice.
  _ida.Future<_ihpk2u4j.GuestGroup> addHousehold(
    int bookingId,
    int householdId,
  ) => caller.callServerEndpoint<_ihpk2u4j.GuestGroup>(
    'guest',
    'addHousehold',
    {
      'bookingId': bookingId,
      'householdId': householdId,
    },
  );

  _ida.Future<_ihpk2u4j.GuestGroup> addGroup(_ihpk2u4j.GuestGroup group) =>
      caller.callServerEndpoint<_ihpk2u4j.GuestGroup>(
        'guest',
        'addGroup',
        {'group': group},
      );

  _ida.Future<_ihpk2u4j.GuestGroup> updateGroup(_ihpk2u4j.GuestGroup group) =>
      caller.callServerEndpoint<_ihpk2u4j.GuestGroup>(
        'guest',
        'updateGroup',
        {'group': group},
      );

  /// Also removes the guests of the group from the booking. Their contacts
  /// stay.
  _ida.Future<void> deleteGroup(int id) => caller.callServerEndpoint<void>(
    'guest',
    'deleteGroup',
    {'id': id},
  );

  /// Adds a contact to a group as a guest.
  _ida.Future<_i44zmmsa.Guest> addGuest(_i44zmmsa.Guest guest) =>
      caller.callServerEndpoint<_i44zmmsa.Guest>(
        'guest',
        'addGuest',
        {'guest': guest},
      );

  /// Adds a guest who is not a contact yet. [contact] is created along with
  /// the guest.
  _ida.Future<_i44zmmsa.Guest> addNewGuest(
    _i44zmmsa.Guest guest,
    _izv2jndr.Contact contact,
  ) => caller.callServerEndpoint<_i44zmmsa.Guest>(
    'guest',
    'addNewGuest',
    {
      'guest': guest,
      'contact': contact,
    },
  );

  _ida.Future<_i44zmmsa.Guest> updateGuest(_i44zmmsa.Guest guest) =>
      caller.callServerEndpoint<_i44zmmsa.Guest>(
        'guest',
        'updateGuest',
        {'guest': guest},
      );

  /// Removes the guest from the booking. The contact stays.
  _ida.Future<void> deleteGuest(int id) => caller.callServerEndpoint<void>(
    'guest',
    'deleteGuest',
    {'id': id},
  );

  /// Puts the guests into a room that their booking holds, or takes them out
  /// of their rooms if [bookingRoomId] is null.
  ///
  /// More guests than beds are accepted, as is a crib where none fits: guests
  /// are often moved around until everybody has a place, and the room shows
  /// that it is overfull meanwhile.
  _ida.Future<void> assign(
    List<int> guestIds,
    int? bookingRoomId,
  ) => caller.callServerEndpoint<void>(
    'guest',
    'assign',
    {
      'guestIds': guestIds,
      'bookingRoomId': bookingRoomId,
    },
  );
}

/// {@category Endpoint}
class EndpointAgeGroup extends EndpointApp {
  EndpointAgeGroup(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ageGroup';

  _ida.Future<List<_iw3hbj1z.AgeGroup>> getAll() =>
      caller.callServerEndpoint<List<_iw3hbj1z.AgeGroup>>(
        'ageGroup',
        'getAll',
        {},
      );

  _ida.Future<_iw3hbj1z.AgeGroup> add(_iw3hbj1z.AgeGroup group) =>
      caller.callServerEndpoint<_iw3hbj1z.AgeGroup>(
        'ageGroup',
        'add',
        {'group': group},
      );

  _ida.Future<_iw3hbj1z.AgeGroup> update(_iw3hbj1z.AgeGroup group) =>
      caller.callServerEndpoint<_iw3hbj1z.AgeGroup>(
        'ageGroup',
        'update',
        {'group': group},
      );

  /// Also deletes the room and meal rates of the age group. An age group
  /// that a fee is limited to or a guest is priced with cannot be deleted.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'ageGroup',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointFee extends EndpointApp {
  EndpointFee(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'fee';

  _ida.Future<List<_iaal8fsz.Fee>> getAll() =>
      caller.callServerEndpoint<List<_iaal8fsz.Fee>>(
        'fee',
        'getAll',
        {},
      );

  _ida.Future<_iaal8fsz.Fee> add(_iaal8fsz.Fee fee) =>
      caller.callServerEndpoint<_iaal8fsz.Fee>(
        'fee',
        'add',
        {'fee': fee},
      );

  _ida.Future<_iaal8fsz.Fee> update(_iaal8fsz.Fee fee) =>
      caller.callServerEndpoint<_iaal8fsz.Fee>(
        'fee',
        'update',
        {'fee': fee},
      );

  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'fee',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointMealPlan extends EndpointApp {
  EndpointMealPlan(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mealPlan';

  _ida.Future<List<_iy1yfvqt.MealPlan>> getAll() =>
      caller.callServerEndpoint<List<_iy1yfvqt.MealPlan>>(
        'mealPlan',
        'getAll',
        {},
      );

  _ida.Future<_iy1yfvqt.MealPlan> add(_iy1yfvqt.MealPlan plan) =>
      caller.callServerEndpoint<_iy1yfvqt.MealPlan>(
        'mealPlan',
        'add',
        {'plan': plan},
      );

  _ida.Future<_iy1yfvqt.MealPlan> update(_iy1yfvqt.MealPlan plan) =>
      caller.callServerEndpoint<_iy1yfvqt.MealPlan>(
        'mealPlan',
        'update',
        {'plan': plan},
      );

  /// Also deletes the meal rates of the plan. A plan that a booking uses
  /// cannot be deleted.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'mealPlan',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointMealRate extends EndpointApp {
  EndpointMealRate(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mealRate';

  _ida.Future<List<_i8b25r61.MealRate>> getBySeason(int seasonId) =>
      caller.callServerEndpoint<List<_i8b25r61.MealRate>>(
        'mealRate',
        'getBySeason',
        {'seasonId': seasonId},
      );

  /// Replaces all meal rates of the season with [rates]. A combination of
  /// meal plan and age group that is left out has no price afterwards.
  _ida.Future<List<_i8b25r61.MealRate>> saveForSeason(
    int seasonId,
    List<_i8b25r61.MealRate> rates,
  ) => caller.callServerEndpoint<List<_i8b25r61.MealRate>>(
    'mealRate',
    'saveForSeason',
    {
      'seasonId': seasonId,
      'rates': rates,
    },
  );
}

/// {@category Endpoint}
class EndpointPriceCategory extends EndpointApp {
  EndpointPriceCategory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'priceCategory';

  _ida.Future<List<_il8lwbsk.PriceCategory>> getAll() =>
      caller.callServerEndpoint<List<_il8lwbsk.PriceCategory>>(
        'priceCategory',
        'getAll',
        {},
      );

  _ida.Future<_il8lwbsk.PriceCategory> add(_il8lwbsk.PriceCategory category) =>
      caller.callServerEndpoint<_il8lwbsk.PriceCategory>(
        'priceCategory',
        'add',
        {'category': category},
      );

  _ida.Future<_il8lwbsk.PriceCategory> update(
    _il8lwbsk.PriceCategory category,
  ) => caller.callServerEndpoint<_il8lwbsk.PriceCategory>(
    'priceCategory',
    'update',
    {'category': category},
  );

  /// Also deletes the room rates of the category. A category that still has
  /// rooms cannot be deleted.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'priceCategory',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointPricing extends EndpointApp {
  EndpointPricing(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pricing';

  /// What the booking costs by the rates and fees as they are now, see
  /// `calculatePrice`. Nothing is stored.
  _ida.Future<_iti0hbb0.BookingPrice> calculate(int bookingId) =>
      caller.callServerEndpoint<_iti0hbb0.BookingPrice>(
        'pricing',
        'calculate',
        {'bookingId': bookingId},
      );
}

/// {@category Endpoint}
class EndpointRoomRate extends EndpointApp {
  EndpointRoomRate(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'roomRate';

  _ida.Future<List<_ijssj09l.RoomRate>> getBySeason(int seasonId) =>
      caller.callServerEndpoint<List<_ijssj09l.RoomRate>>(
        'roomRate',
        'getBySeason',
        {'seasonId': seasonId},
      );

  /// Replaces all room rates of the season with [rates]. A combination of
  /// price category and age group that is left out has no price afterwards.
  _ida.Future<List<_ijssj09l.RoomRate>> saveForSeason(
    int seasonId,
    List<_ijssj09l.RoomRate> rates,
  ) => caller.callServerEndpoint<List<_ijssj09l.RoomRate>>(
    'roomRate',
    'saveForSeason',
    {
      'seasonId': seasonId,
      'rates': rates,
    },
  );
}

/// {@category Endpoint}
class EndpointSeason extends EndpointApp {
  EndpointSeason(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'season';

  _ida.Future<List<_id21ndqx.Season>> getAll() =>
      caller.callServerEndpoint<List<_id21ndqx.Season>>(
        'season',
        'getAll',
        {},
      );

  _ida.Future<_id21ndqx.Season> add(_id21ndqx.Season season) =>
      caller.callServerEndpoint<_id21ndqx.Season>(
        'season',
        'add',
        {'season': season},
      );

  _ida.Future<_id21ndqx.Season> update(_id21ndqx.Season season) =>
      caller.callServerEndpoint<_id21ndqx.Season>(
        'season',
        'update',
        {'season': season},
      );

  /// Also deletes the room and meal rates of the season.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'season',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointRoom extends EndpointApp {
  EndpointRoom(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'room';

  _ida.Future<List<_i5smwbna.Room>> getAll() =>
      caller.callServerEndpoint<List<_i5smwbna.Room>>(
        'room',
        'getAll',
        {},
      );

  _ida.Future<_i5smwbna.Room?> getById(int id) =>
      caller.callServerEndpoint<_i5smwbna.Room?>(
        'room',
        'getById',
        {'id': id},
      );

  _ida.Future<_i5smwbna.Room> add(_i5smwbna.Room room) =>
      caller.callServerEndpoint<_i5smwbna.Room>(
        'room',
        'add',
        {'room': room},
      );

  _ida.Future<_i5smwbna.Room> update(_i5smwbna.Room room) =>
      caller.callServerEndpoint<_i5smwbna.Room>(
        'room',
        'update',
        {'room': room},
      );

  /// A room that a booking holds or held cannot be deleted, only set
  /// inactive.
  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'room',
    'delete',
    {'id': id},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    user = EndpointUser(this);
    billing = EndpointBilling(this);
    booking = EndpointBooking(this);
    contact = EndpointContact(this);
    household = EndpointHousehold(this);
    organization = EndpointOrganization(this);
    dashboard = EndpointDashboard(this);
    donation = EndpointDonation(this);
    operator = EndpointOperator(this);
    greeting = EndpointGreeting(this);
    guest = EndpointGuest(this);
    ageGroup = EndpointAgeGroup(this);
    fee = EndpointFee(this);
    mealPlan = EndpointMealPlan(this);
    mealRate = EndpointMealRate(this);
    priceCategory = EndpointPriceCategory(this);
    pricing = EndpointPricing(this);
    roomRate = EndpointRoomRate(this);
    season = EndpointSeason(this);
    room = EndpointRoom(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointUser user;

  late final EndpointBilling billing;

  late final EndpointBooking booking;

  late final EndpointContact contact;

  late final EndpointHousehold household;

  late final EndpointOrganization organization;

  late final EndpointDashboard dashboard;

  late final EndpointDonation donation;

  late final EndpointOperator operator;

  late final EndpointGreeting greeting;

  late final EndpointGuest guest;

  late final EndpointAgeGroup ageGroup;

  late final EndpointFee fee;

  late final EndpointMealPlan mealPlan;

  late final EndpointMealRate mealRate;

  late final EndpointPriceCategory priceCategory;

  late final EndpointPricing pricing;

  late final EndpointRoomRate roomRate;

  late final EndpointSeason season;

  late final EndpointRoom room;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'user': user,
    'billing': billing,
    'booking': booking,
    'contact': contact,
    'household': household,
    'organization': organization,
    'dashboard': dashboard,
    'donation': donation,
    'operator': operator,
    'greeting': greeting,
    'guest': guest,
    'ageGroup': ageGroup,
    'fee': fee,
    'mealPlan': mealPlan,
    'mealRate': mealRate,
    'priceCategory': priceCategory,
    'pricing': pricing,
    'roomRate': roomRate,
    'season': season,
    'room': room,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
