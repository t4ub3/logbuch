import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class FeeEndpoint extends AppEndpoint {
  Future<List<Fee>> getAll(Session session) async {
    return Fee.db.find(session, orderBy: (t) => t.name);
  }

  Future<Fee> add(Session session, Fee fee) async {
    requireAdmin(session);
    return await Fee.db.insertRow(session, _validated(fee));
  }

  Future<Fee> update(Session session, Fee fee) async {
    requireAdmin(session);
    return await Fee.db.updateRow(session, _validated(fee));
  }

  Future<void> delete(Session session, int id) async {
    requireAdmin(session);
    await Fee.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }

  /// The tax rate is stored in basis points, so 700 is 7 %.
  Fee _validated(Fee fee) {
    final name = requireName(fee.name);
    requireAmount(fee.amount);
    if (fee.taxRate < 0 || fee.taxRate > 10000) {
      throw ValidationException(reason: ValidationError.invalidTaxRate);
    }
    return fee.copyWith(name: name);
  }
}
