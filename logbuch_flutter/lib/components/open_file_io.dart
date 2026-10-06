import 'dart:io';
import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';

/// Writes the file to the temporary directory and opens it from there.
Future<void> openFile(String name, Uint8List bytes) async {
  final separator = Platform.pathSeparator;
  final file = File('${Directory.systemTemp.path}$separator$name');
  await file.writeAsBytes(bytes, flush: true);
  if (!await launchUrl(Uri.file(file.path))) {
    throw StateError('Nothing opens ${file.path}');
  }
}
