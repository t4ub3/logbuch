import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class MealRateEndpoint extends AppEndpoint {
  Future<List<MealRate>> getBySeason(Session session, int seasonId) async {
    return MealRate.db.find(
      session,
      where: (t) => t.seasonId.equals(seasonId),
    );
  }

  /// Replaces all meal rates of the season with [rates]. A combination of
  /// meal plan and age group that is left out has no price afterwards.
  Future<List<MealRate>> saveForSeason(
    Session session,
    int seasonId,
    List<MealRate> rates,
  ) async {
    requireAdmin(session);
    final cells = <(int, int)>{};
    for (final rate in rates) {
      requireAmount(rate.pricePerNight);
      if (!cells.add((rate.mealPlanId, rate.ageGroupId))) {
        throw ValidationException(reason: ValidationError.duplicateRate);
      }
    }

    return session.db.transaction((transaction) async {
      await MealRate.db.deleteWhere(
        session,
        where: (t) => t.seasonId.equals(seasonId),
        transaction: transaction,
      );
      if (rates.isEmpty) return [];
      return MealRate.db.insert(
        session,
        [for (final rate in rates) rate.copyWith(id: null, seasonId: seasonId)],
        transaction: transaction,
      );
    });
  }
}
