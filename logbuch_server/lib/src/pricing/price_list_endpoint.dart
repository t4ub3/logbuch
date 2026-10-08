import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class PriceListEndpoint extends AppEndpoint {
  Future<List<PriceList>> getAll(Session session) async {
    return PriceList.db.find(session, orderBy: (t) => t.validFrom);
  }

  /// Adds a price list. It starts with the prices that are in force on its
  /// first day, so that only what changes has to be entered.
  Future<PriceList> add(Session session, PriceList list) async {
    requireAdmin(session);
    final validated = await _validated(session, list);
    return session.db.transaction((transaction) async {
      final before = await PriceList.db.findFirstRow(
        session,
        where: (t) => t.validFrom < validated.validFrom,
        orderByList: (t) => [t.validFrom.desc()],
        transaction: transaction,
      );
      final added = await PriceList.db.insertRow(
        session,
        validated,
        transaction: transaction,
      );
      if (before != null) {
        await _replacePrices(
          session,
          added.id!,
          await _prices(session, before.id!, transaction),
          transaction,
        );
      }
      return added;
    });
  }

  Future<PriceList> update(Session session, PriceList list) async {
    requireAdmin(session);
    final validated = await _validated(session, list);
    return await PriceList.db.updateRow(session, validated);
  }

  /// Also deletes the prices of the list.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    await PriceList.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  Future<PriceListPrices> getPrices(Session session, int priceListId) {
    return _prices(session, priceListId, null);
  }

  /// Replaces all prices of the list with [prices]. What is left out has no
  /// price afterwards.
  Future<PriceListPrices> savePrices(
    Session session,
    int priceListId,
    PriceListPrices prices,
  ) async {
    requireAdmin(session);
    final roomRates = <(int, int)>{};
    for (final rate in prices.roomRates) {
      requireAmount(rate.pricePerNight);
      if (!roomRates.add((rate.unitTypeId, rate.ageGroupId))) {
        throw ValidationException(reason: ValidationError.duplicateRate);
      }
    }
    final unitPrices = <int>{};
    for (final price in prices.unitPrices) {
      requireAmount(price.pricePerNight ?? 0);
      requireAmount(price.dayUsePrice ?? 0);
      if (!unitPrices.add(price.unitTypeId)) {
        throw ValidationException(reason: ValidationError.duplicateRate);
      }
    }
    final mealRates = <(int, int)>{};
    for (final rate in prices.mealRates) {
      requireAmount(rate.pricePerNight);
      if (!mealRates.add((rate.mealPlanId, rate.ageGroupId))) {
        throw ValidationException(reason: ValidationError.duplicateRate);
      }
    }
    final feePrices = <int>{};
    for (final price in prices.feePrices) {
      requireAmount(price.amount);
      if (!feePrices.add(price.feeId)) {
        throw ValidationException(reason: ValidationError.duplicateRate);
      }
    }

    return session.db.transaction((transaction) async {
      await _replacePrices(session, priceListId, prices, transaction);
      return _prices(session, priceListId, transaction);
    });
  }

  Future<PriceListPrices> _prices(
    Session session,
    int priceListId,
    Transaction? transaction,
  ) async {
    return PriceListPrices(
      roomRates: await RoomRate.db.find(
        session,
        where: (t) => t.priceListId.equals(priceListId),
        transaction: transaction,
      ),
      unitPrices: await UnitPrice.db.find(
        session,
        where: (t) => t.priceListId.equals(priceListId),
        transaction: transaction,
      ),
      mealRates: await MealRate.db.find(
        session,
        where: (t) => t.priceListId.equals(priceListId),
        transaction: transaction,
      ),
      feePrices: await FeePrice.db.find(
        session,
        where: (t) => t.priceListId.equals(priceListId),
        transaction: transaction,
      ),
    );
  }

  Future<void> _replacePrices(
    Session session,
    int priceListId,
    PriceListPrices prices,
    Transaction transaction,
  ) async {
    await RoomRate.db.deleteWhere(
      session,
      where: (t) => t.priceListId.equals(priceListId),
      transaction: transaction,
    );
    await UnitPrice.db.deleteWhere(
      session,
      where: (t) => t.priceListId.equals(priceListId),
      transaction: transaction,
    );
    await MealRate.db.deleteWhere(
      session,
      where: (t) => t.priceListId.equals(priceListId),
      transaction: transaction,
    );
    await FeePrice.db.deleteWhere(
      session,
      where: (t) => t.priceListId.equals(priceListId),
      transaction: transaction,
    );

    final roomRates = [
      for (final rate in prices.roomRates)
        rate.copyWith(id: null, priceListId: priceListId),
    ];
    // A unit price without any amount says nothing.
    final unitPrices = [
      for (final price in prices.unitPrices)
        if (price.pricePerNight != null || price.dayUsePrice != null)
          price.copyWith(id: null, priceListId: priceListId),
    ];
    final mealRates = [
      for (final rate in prices.mealRates)
        rate.copyWith(id: null, priceListId: priceListId),
    ];
    final feePrices = [
      for (final price in prices.feePrices)
        price.copyWith(id: null, priceListId: priceListId),
    ];
    if (roomRates.isNotEmpty) {
      await RoomRate.db.insert(session, roomRates, transaction: transaction);
    }
    if (unitPrices.isNotEmpty) {
      await UnitPrice.db.insert(session, unitPrices, transaction: transaction);
    }
    if (mealRates.isNotEmpty) {
      await MealRate.db.insert(session, mealRates, transaction: transaction);
    }
    if (feePrices.isNotEmpty) {
      await FeePrice.db.insert(session, feePrices, transaction: transaction);
    }
  }

  /// No two lists begin on the same day, so that it is always clear which
  /// one prices a night.
  Future<PriceList> _validated(Session session, PriceList list) async {
    final name = requireName(list.name);
    requireDateOnly(list.validFrom);
    final sameDay = await PriceList.db.findFirstRow(
      session,
      where: (t) =>
          t.validFrom.equals(list.validFrom) & t.id.notEquals(list.id),
    );
    if (sameDay != null) {
      throw ValidationException(
        reason: ValidationError.priceListDateTaken,
        detail: sameDay.name,
      );
    }
    return list.copyWith(name: name);
  }
}
