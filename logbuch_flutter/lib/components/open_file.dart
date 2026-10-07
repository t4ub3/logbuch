import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logbuch_flutter/providers/status_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'open_file_stub.dart' if (dart.library.io) 'open_file_io.dart';

part 'open_file.g.dart';

/// Shows a file to the user with the application that the system opens such
/// files with.
typedef FileOpener = Future<void> Function(String name, Uint8List bytes);

/// How files are opened. Tests replace it, so that nothing opens for real.
@Riverpod(keepAlive: true)
FileOpener fileOpener(Ref ref) => openFile;

/// Shows [pdf], a document the server made, to the user as the file [name]
/// and says so in the status bar.
Future<void> openDocument(WidgetRef ref, String name, ByteData pdf) async {
  final status = ref.read(statusProvider.notifier);
  await ref.read(fileOpenerProvider)(
    name,
    // The bytes may be a part of a larger buffer.
    pdf.buffer.asUint8List(pdf.offsetInBytes, pdf.lengthInBytes),
  );
  status.documentCreated(name);
}
