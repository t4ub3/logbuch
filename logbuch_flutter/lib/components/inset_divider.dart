import 'package:flutter/material.dart';

/// A thin horizontal divider with the same gap on the left and right.
class InsetDivider extends StatelessWidget {
  const InsetDivider({super.key, this.indent = 16});

  /// Gap on both the left and the right side.
  final double indent;

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, indent: indent, endIndent: indent);
  }
}
