# Log|Buch

Log|Buch manages group guest houses (_Gruppenhäuser_) in Germany. It covers bookings with guest lists, room assignment, pricing, invoices and payments, and yearly donation receipts. The UI is in English and German.

It is a Flutter app with a [Serverpod](https://serverpod.dev) backend, in one Dart workspace:

| Package           | What it is                                                     |
| ----------------- | -------------------------------------------------------------- |
| `logbuch_server`  | Serverpod server: models (`*.spy.yaml`), endpoints, migrations |
| `logbuch_client`  | Client generated from the server. Don't edit it                |
| `logbuch_flutter` | Flutter app (Windows, macOS, web)                              |

Conventions and business rules are in [AGENTS.md](AGENTS.md).

## Show demo

You can see a demo with dummy data on https://logbuch.serverpod.space/. Sign in as `admin@example.com` with the password `admin`.

The demo deployment sets the environment variable `LOGBUCH_DEMO_DATA=true` (`scloud variable set LOGBUCH_DEMO_DATA true`). With it, the server adds the demo data from `lib/src/demo/` and the admin each time it starts. It only adds what is missing and keeps what is there. Never set it for a real installation.

## Running locally

You need the Flutter SDK (Dart `^3.12.2`) and the Serverpod CLI 4.0.3:

```sh
dart pub global activate serverpod_cli 4.0.3
```

Docker isn't needed. In development and in tests, Serverpod runs an embedded PostgreSQL, which keeps its data in `logbuch_server/.serverpod/`.

1. Create `logbuch_server/config/passwords.yaml`. It isn't in git, so get a copy from a teammate. Under `development` and `test`, it needs `database`, `serviceSecret`, `emailSecretHashPepper`, `jwtHmacSha512PrivateKey` and `jwtRefreshTokenHashPepper`.
2. Start the server and the app:

   ```sh
   dart pub get
   cd logbuch_server
   serverpod start
   ```

   This applies pending migrations and starts the server on `localhost:8080`. It also launches the Flutter app and watches for changes: it regenerates code and hot reloads the server and the app. Which apps it can start is set under `flutter_apps` in `logbuch_server/pubspec.yaml`.

3. Sign up in the app. The verification code is printed in the server log. The first user to sign up becomes admin; anyone after that waits until an admin gives them a role.
4. Optional, to add demo data and the admin `admin@example.com` (password `admin`) to the development database: `serverpod run seed` in `logbuch_server`. Running it again adds nothing new.

## Tests

```sh
cd logbuch_server && dart test      # server, uses its own embedded database
cd logbuch_flutter && flutter test  # app, against a fake client
```

After changing texts (`lib/i18n/*.i18n.json`) or Riverpod providers, regenerate them with `dart run build_runner build --delete-conflicting-outputs` in `logbuch_flutter`.
