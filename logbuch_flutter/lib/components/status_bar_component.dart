import 'package:flutter/material.dart';

class StatusBarComponent extends StatelessWidget {
  const StatusBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFF9000),
      child: Text("status bar"),
    );
  }
}
