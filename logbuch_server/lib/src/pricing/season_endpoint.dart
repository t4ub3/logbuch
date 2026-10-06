import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class SeasonEndpoint extends AppEndpoint {
  Future<List<Season>> getAll(Session session) async {
    return Season.db.find(session, orderBy: (t) => t.validFrom);
  }

  Future<Season> add(Session session, Season season) async {
    requireAdmin(session);
    final validated = await _validated(session, season);
    return await Season.db.insertRow(session, validated);
  }

  Future<Season> update(Session session, Season season) async {
    requireAdmin(session);
    final validated = await _validated(session, season);
    return await Season.db.updateRow(session, validated);
  }

  /// Also deletes the room and meal rates of the season.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    await Season.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// Seasons include both their first and last day and must not overlap, so
  /// that a night never belongs to two seasons.
  Future<Season> _validated(Session session, Season season) async {
    final name = requireName(season.name);
    requireDateOnly(season.validFrom);
    requireDateOnly(season.validTo);
    if (season.validTo.isBefore(season.validFrom)) {
      throw ValidationException(reason: ValidationError.invalidDateRange);
    }

    final overlapping = await Season.db.findFirstRow(
      session,
      where: (t) =>
          (t.validFrom <= season.validTo) &
          (t.validTo >= season.validFrom) &
          t.id.notEquals(season.id),
    );
    if (overlapping != null) {
      throw ValidationException(
        reason: ValidationError.seasonOverlap,
        detail: overlapping.name,
      );
    }
    return season.copyWith(name: name);
  }
}
