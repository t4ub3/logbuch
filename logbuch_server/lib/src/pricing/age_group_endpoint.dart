import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class AgeGroupEndpoint extends AppEndpoint {
  Future<List<AgeGroup>> getAll(Session session) async {
    return AgeGroup.db.find(session, orderBy: (t) => t.minAge);
  }

  Future<AgeGroup> add(Session session, AgeGroup group) async {
    requireAdmin(session);
    final validated = await _validated(session, group);
    return await AgeGroup.db.insertRow(session, validated);
  }

  Future<AgeGroup> update(Session session, AgeGroup group) async {
    requireAdmin(session);
    final validated = await _validated(session, group);
    return await AgeGroup.db.updateRow(session, validated);
  }

  /// Also deletes the room and meal rates of the age group. An age group
  /// that a fee is limited to or a guest is priced with cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final fees = await Fee.db.count(
      session,
      where: (t) => t.ageGroupId.equals(id),
    );
    final guests = await Guest.db.count(
      session,
      where: (t) => t.ageGroupOverrideId.equals(id),
    );
    if (fees + guests > 0) {
      throw ValidationException(reason: ValidationError.inUse);
    }
    await AgeGroup.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// Age ranges include both ends and must not overlap, so that an age never
  /// belongs to two groups. A group without `maxAge` is open-ended.
  Future<AgeGroup> _validated(Session session, AgeGroup group) async {
    final name = requireName(group.name);
    final maxAge = group.maxAge;
    if (group.minAge < 0 || (maxAge != null && maxAge < group.minAge)) {
      throw ValidationException(reason: ValidationError.invalidAgeRange);
    }

    final others = await AgeGroup.db.find(
      session,
      where: (t) => t.id.notEquals(group.id),
    );
    for (final other in others) {
      final otherMax = other.maxAge;
      final startsInTime = otherMax == null || group.minAge <= otherMax;
      final endsInTime = maxAge == null || other.minAge <= maxAge;
      if (startsInTime && endsInTime) {
        throw ValidationException(
          reason: ValidationError.ageGroupOverlap,
          detail: other.name,
        );
      }
    }
    return group.copyWith(name: name);
  }
}
