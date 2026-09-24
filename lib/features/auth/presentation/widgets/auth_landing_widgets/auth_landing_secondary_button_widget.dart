import 'package:flutter/material.dart';

class LandingSecondaryButton extends StatelessWidget {
  const LandingSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF191C24),

          foregroundColor: const Color(0xFFF5F5F5),

          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.12),
            width: 1,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        child: Text(
          label,

          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
