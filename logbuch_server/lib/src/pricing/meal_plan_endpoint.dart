import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class MealPlanEndpoint extends AppEndpoint {
  Future<List<MealPlan>> getAll(Session session) async {
    return MealPlan.db.find(session, orderBy: (t) => t.id);
  }

  Future<MealPlan> add(Session session, MealPlan plan) async {
    requireAdmin(session);
    return await MealPlan.db.insertRow(session, _validated(plan));
  }

  Future<MealPlan> update(Session session, MealPlan plan) async {
    requireAdmin(session);
    return await MealPlan.db.updateRow(session, _validated(plan));
  }

  /// Also deletes the meal rates of the plan. A plan that a booking uses
  /// cannot be deleted.
  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    final bookings = await Booking.db.count(
      session,
      where: (t) => t.mealPlanId.equals(id),
    );
    if (bookings > 0) throw ValidationException(reason: ValidationError.inUse);
    await MealPlan.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  MealPlan _validated(MealPlan plan) =>
      plan.copyWith(name: requireName(plan.name));
}
