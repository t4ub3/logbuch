import 'dart:typed_data';

/// Where there are no files to write, as in a browser.
Future<void> openFile(String name, Uint8List bytes) {
  throw UnsupportedError('Opening files is not supported here yet.');
}
