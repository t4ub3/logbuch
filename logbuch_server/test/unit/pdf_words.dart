import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// The words that a PDF made by the pdf package draws, in drawing order.
List<String> wordsOf(Uint8List pdf) {
  final text = latin1.decode(pdf);
  final words = <String>[];
  final streams = RegExp(r'stream\r?\n(.*?)\r?\nendstream', dotAll: true);
  for (final stream in streams.allMatches(text)) {
    final List<int> content;
    try {
      content = zlib.decode(latin1.encode(stream[1]!));
    } on FormatException {
      continue;
    }
    // Text is drawn as arrays of strings: [(Rech) 20 (nung)] TJ
    final arrays = RegExp(r'\[(.*?)\]\s*TJ', dotAll: true);
    for (final array in arrays.allMatches(latin1.decode(content))) {
      final parts = RegExp(r'\(((?:\\.|[^\\)])*)\)').allMatches(array[1]!);
      words.add(
        parts
            .map((part) => part[1]!)
            .join()
            .replaceAllMapped(
              RegExp(r'\\([0-7]{3})'),
              (octal) => String.fromCharCode(int.parse(octal[1]!, radix: 8)),
            )
            .replaceAllMapped(RegExp(r'\\(.)'), (escaped) => escaped[1]!),
      );
    }
  }
  return words;
}
