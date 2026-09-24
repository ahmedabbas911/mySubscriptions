import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String label;

  const FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFFD7DEE6),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
