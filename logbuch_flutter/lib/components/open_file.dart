import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'open_file_stub.dart' if (dart.library.io) 'open_file_io.dart';

part 'open_file.g.dart';

/// Shows a file to the user with the application that the system opens such
/// files with.
typedef FileOpener = Future<void> Function(String name, Uint8List bytes);

/// How files are opened. Tests replace it, so that nothing opens for real.
@Riverpod(keepAlive: true)
FileOpener fileOpener(Ref ref) => openFile;
