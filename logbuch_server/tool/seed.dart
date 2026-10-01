/// Seeds the development database with dummy data.
///
/// Requires the server to be running (`serverpod start`), which also runs the
/// embedded development database. Run from `logbuch_server`:
///
///   serverpod run seed
///
/// Does nothing if contacts, rooms or bookings already exist.
library;

import 'dart:convert';
import 'dart:io';

import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:postgres/postgres.dart';

// ignore_for_file: avoid_print

Future<void> main() async {
  final dir = File.fromUri(
    Platform.script.resolve('../.serverpod/development/'),
  ).path;
  final conn = await Connection.open(
    Endpoint(
      host: File('$dir/run/.s.PGSQL.5432').absolute.path,
      isUnixSocket: true,
      database: 'logbuch',
      username: 'postgres',
      password: File('$dir/postgres.password').readAsStringSync().trim(),
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  for (final t in ['contacts', 'rooms', 'bookings']) {
    final r = await conn.execute('SELECT count(*) FROM $t');
    if ((r.first[0] as int) > 0) {
      print('Table $t is not empty, skipping seed.');
      await conn.close();
      return;
    }
  }

  await conn.runTx((tx) async {
    final contacts = <Contact>[];
    for (final c in [
      ('Anna', 'Schmidt', 'anna.schmidt@example.com', '+49 151 1234567'),
      ('Lukas', 'Müller', 'lukas.mueller@example.com', '+49 160 2345678'),
      ('Marie', 'Weber', 'marie.weber@example.com', null),
      ('Felix', 'Wagner', null, '+49 171 3456789'),
      ('Sophie', 'Becker', 'sophie.becker@example.com', '+49 152 4567890'),
    ]) {
      final r = await tx.execute(
        Sql.named(
          'INSERT INTO contacts ("firstName", "lastName", mail, phone) '
          'VALUES (@f, @l, @m, @p) RETURNING id, "createdAt"',
        ),
        parameters: {'f': c.$1, 'l': c.$2, 'm': c.$3, 'p': c.$4},
      );
      contacts.add(
        Contact(
          id: r.first[0] as int,
          createdAt: r.first[1] as DateTime,
          firstName: c.$1,
          lastName: c.$2,
          mail: c.$3,
          phone: c.$4,
        ),
      );
    }

    for (var floor = 1; floor <= 3; floor++) {
      for (var n = 1; n <= 5; n++) {
        await tx.execute(
          Sql.named(
            'INSERT INTO rooms ("roomNumber", "bedAmount") VALUES (@r, @b)',
          ),
          parameters: {
            'r': '$floor${n.toString().padLeft(2, '0')}',
            'b': n % 4 + 1,
          },
        );
      }
    }

    for (final b in [
      (
        'Klassenfahrt 7b',
        DateTime.utc(2026, 10, 12),
        DateTime.utc(2026, 10, 16),
        contacts[0],
      ),
      (
        'Chorwochenende',
        DateTime.utc(2026, 11, 6),
        DateTime.utc(2026, 11, 8),
        contacts[2],
      ),
      (
        'Jugendfreizeit',
        DateTime.utc(2027, 7, 20),
        DateTime.utc(2027, 7, 31),
        contacts[4],
      ),
    ]) {
      await tx.execute(
        Sql.named(
          'INSERT INTO bookings (title, "from", "to", lead) '
          'VALUES (@t, @from, @to, @lead::json)',
        ),
        parameters: {
          't': b.$1,
          'from': b.$2,
          'to': b.$3,
          'lead': jsonEncode(b.$4.toJson()),
        },
      );
    }
  });

  for (final t in ['contacts', 'rooms', 'bookings']) {
    final r = await conn.execute('SELECT count(*) FROM $t');
    print('$t: ${r.first[0]}');
  }
  await conn.close();
}
