import 'package:flutter/material.dart';

class RegisterIcon extends StatelessWidget {
  const RegisterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,

      decoration: BoxDecoration(
        color: const Color(0xFFFF8A00),
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8A00).withValues(alpha: 0.22),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),

      child: const Icon(
        Icons.person_add_alt_1_rounded,
        color: Colors.white,
        size: 34,
      ),
    );
  }
}
