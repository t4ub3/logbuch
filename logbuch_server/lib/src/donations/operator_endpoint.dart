import 'package:logbuch_server/src/auth/roles.dart';
import 'package:logbuch_server/src/common/validation.dart';
import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

/// The details of the organisation that runs the house. There is one set of
/// them per installation.
class OperatorEndpoint extends AppEndpoint {
  /// The details, or null if none were entered yet.
  Future<Operator?> load(Session session) async {
    return Operator.db.findFirstRow(session, orderBy: (t) => t.id);
  }

  Future<Operator> save(Session session, Operator operator) async {
    requireAdmin(session);
    if (operator.noticeDate case final date?) requireDateOnly(date);
    final stored = await load(session);
    final details = operator.copyWith(
      id: stored?.id,
      name: requireName(operator.name),
    );
    return stored == null
        ? await Operator.db.insertRow(session, details)
        : await Operator.db.updateRow(session, details);
  }
}
