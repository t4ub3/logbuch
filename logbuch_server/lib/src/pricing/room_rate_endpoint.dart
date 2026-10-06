import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class RoomRateEndpoint extends AppEndpoint {
  Future<List<RoomRate>> getBySeason(Session session, int seasonId) async {
    return RoomRate.db.find(
      session,
      where: (t) => t.seasonId.equals(seasonId),
    );
  }

  /// Replaces all room rates of the season with [rates]. A combination of
  /// price category and age group that is left out has no price afterwards.
  Future<List<RoomRate>> saveForSeason(
    Session session,
    int seasonId,
    List<RoomRate> rates,
  ) async {
    requireAdmin(session);
    final cells = <(int, int)>{};
    for (final rate in rates) {
      requireAmount(rate.pricePerNight);
      if (!cells.add((rate.priceCategoryId, rate.ageGroupId))) {
        throw ValidationException(reason: ValidationError.duplicateRate);
      }
    }

    return session.db.transaction((transaction) async {
      await RoomRate.db.deleteWhere(
        session,
        where: (t) => t.seasonId.equals(seasonId),
        transaction: transaction,
      );
      if (rates.isEmpty) return [];
      return RoomRate.db.insert(
        session,
        [for (final rate in rates) rate.copyWith(id: null, seasonId: seasonId)],
        transaction: transaction,
      );
    });
  }
}
