import 'package:logbuch_server/src/generated/serverpod.dart';

/// Today in Germany, as a date at midnight UTC. Asked from the database,
/// which knows the time zone whatever zone the server runs in.
Future<DateTime> todayInGermany(
  Session session, {
  Transaction? transaction,
}) async {
  final result = await session.db.unsafeQuery(
    "SELECT (now() AT TIME ZONE 'Europe/Berlin')::date::timestamp",
    transaction: transaction,
  );
  final today = result.first.first as DateTime;
  return DateTime.utc(today.year, today.month, today.day);
}
