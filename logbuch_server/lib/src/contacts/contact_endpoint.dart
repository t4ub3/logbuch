import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class ContactEndpoint extends AppEndpoint {
  Future<List<Contact>> getAll(Session session) async {
    return Contact.db.find(
      session,
      orderByList: (t) => [t.lastName.asc(), t.firstName.asc()],
      include: Contact.include(organization: Organization.include()),
    );
  }

  Future<Contact?> getById(Session session, int id) async {
    return Contact.db.findById(
      session,
      id,
      include: Contact.include(organization: Organization.include()),
    );
  }

  Future<Contact> add(Session session, Contact contact) async {
    requireAdmin(session);
    return await Contact.db.insertRow(session, validatedContact(contact));
  }

  Future<Contact> update(Session session, Contact contact) async {
    requireAdmin(session);
    return await Contact.db.updateRow(session, validatedContact(contact));
  }

  /// A contact that leads a booking, is a guest of one, pays for one or
  /// made a donation cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final bookings = await Booking.db.count(
      session,
      where: (t) => t.leadId.equals(id),
    );
    final stays = await Guest.db.count(
      session,
      where: (t) => t.contactId.equals(id),
    );
    final folios = await Folio.db.count(
      session,
      where: (t) => t.payerId.equals(id),
    );
    final donations = await Donation.db.count(
      session,
      where: (t) => t.contactId.equals(id),
    );
    if (bookings + stays + folios + donations > 0) {
      throw ValidationException(reason: ValidationError.inUse);
    }
    await Contact.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

/// Checks a contact before it is stored. Guests of large groups are often
/// only known by one name, so either the first or the last name is enough.
Contact validatedContact(Contact contact) {
  final firstName = contact.firstName.trim();
  final lastName = contact.lastName.trim();
  if (firstName.isEmpty && lastName.isEmpty) {
    throw ValidationException(reason: ValidationError.nameRequired);
  }
  if (contact.birthDate case final birthDate?) requireDateOnly(birthDate);
  return contact.copyWith(firstName: firstName, lastName: lastName);
}
