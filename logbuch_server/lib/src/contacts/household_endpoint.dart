import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

/// Households: contacts who usually travel together, such as a family.
class HouseholdEndpoint extends AppEndpoint {
  /// All households with their members and the contacts of those.
  Future<List<Household>> getAll(Session session) async {
    return Household.db.find(
      session,
      orderBy: (t) => t.name,
      include: _withMembers(),
    );
  }

  /// Stores the household, new or changed, with the contacts in [memberIds]
  /// as its members. Contacts that are left out are no longer members.
  Future<Household> save(
    Session session,
    Household household,
    List<int> memberIds,
  ) async {
    requireAdmin(session);
    final named = household.copyWith(name: requireName(household.name));
    final wanted = memberIds.toSet();

    final id = await session.db.transaction((transaction) async {
      final stored = named.id == null
          ? await Household.db.insertRow(
              session,
              named,
              transaction: transaction,
            )
          : await Household.db.updateRow(
              session,
              named,
              transaction: transaction,
            );
      final members = await HouseholdMember.db.find(
        session,
        where: (t) => t.householdId.equals(stored.id),
        transaction: transaction,
      );
      final current = {for (final member in members) member.contactId};
      final removed = current.difference(wanted);
      final added = wanted.difference(current);
      if (removed.isNotEmpty) {
        await HouseholdMember.db.deleteWhere(
          session,
          where: (t) =>
              t.householdId.equals(stored.id) & t.contactId.inSet(removed),
          transaction: transaction,
        );
      }
      if (added.isNotEmpty) {
        await HouseholdMember.db.insert(
          session,
          [
            for (final contactId in added)
              HouseholdMember(householdId: stored.id!, contactId: contactId),
          ],
          transaction: transaction,
        );
      }
      return stored.id!;
    });
    return (await Household.db.findById(
      session,
      id,
      include: _withMembers(),
    ))!;
  }

  /// Removes the household. Its members stay as contacts.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    await Household.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

HouseholdInclude _withMembers() => Household.include(
  members: HouseholdMember.includeList(
    orderBy: (t) => t.id,
    include: HouseholdMember.include(contact: Contact.include()),
  ),
);
