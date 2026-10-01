import 'package:logbuch_client/logbuch_client.dart';
import 'package:logbuch_flutter/client.dart' as global;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_provider.g.dart';

/// Exposes the global Serverpod client so providers can depend on it and
/// tests can override it.
@Riverpod(keepAlive: true)
Client serverpodClient(Ref ref) => global.client;
