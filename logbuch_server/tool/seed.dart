/// Fills the development database with demo data, see [DemoData].
///
/// Run from `logbuch_server`, whether `serverpod start` is running or not:
///
///   serverpod run seed
///
/// What is in the database already is kept, and running this again adds
/// nothing.
///
/// The data is created through the endpoints, so this is built like an
/// integration test: `withServerpod` runs a server inside this process and
/// lets the endpoints be called as an admin. Here it works on the
/// development database instead of an empty one, and keeps what it wrote.
library;

import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/roles.dart';
import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'demo_data.dart';

void main() {
  withServerpod(
    'The demo data',
    (sessionBuilder, endpoints) {
      test('is added to the development database', () async {
        final now = DateTime.now();
        await DemoData(
          sessionBuilder.asAdmin,
          endpoints,
          today: DateTime.utc(now.year, now.month, now.day),
        ).seed();
      }, timeout: const Timeout(Duration(minutes: 10)));
    },
    ephemeralDatabase: false,
    rollbackDatabase: RollbackDatabase.disabled,
    // The development server keeps its database up to date itself.
    applyMigrations: false,
    configOverride: (config) =>
        config.copyWith(database: _developmentDatabase()),
  );
}

/// The database of `config/development.yaml`. The rest of the configuration
/// stays that of the tests, whose servers listen on ports of their own and
/// so do not get in the way of a development server that is running.
DatabaseConfig _developmentDatabase() {
  // The database runs from the data directory that the configuration
  // names, which holds its password as well, so none is given here.
  return ServerpodConfig.load('development', null, {
    'database': '',
  }).database!.withResolvedLocalPath(Directory.current.path);
}
