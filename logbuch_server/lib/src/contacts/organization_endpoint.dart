import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class OrganizationEndpoint extends AppEndpoint {
  Future<List<Organization>> getAll(Session session) async {
    return Organization.db.find(session, orderBy: (t) => t.name);
  }

  Future<Organization> add(Session session, Organization organization) async {
    requireAdmin(session);
    return await Organization.db.insertRow(session, _validated(organization));
  }

  Future<Organization> update(
    Session session,
    Organization organization,
  ) async {
    requireAdmin(session);
    return await Organization.db.updateRow(session, _validated(organization));
  }

  /// The contacts of the organization stay, without an organization. An
  /// organization that a booking belongs to cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final bookings = await Booking.db.count(
      session,
      where: (t) => t.organizationId.equals(id),
    );
    if (bookings > 0) throw ValidationException(reason: ValidationError.inUse);
    await Organization.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  Organization _validated(Organization organization) =>
      organization.copyWith(name: requireName(organization.name));
}
