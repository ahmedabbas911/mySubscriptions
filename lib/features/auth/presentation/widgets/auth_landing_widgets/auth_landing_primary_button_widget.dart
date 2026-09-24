import 'package:flutter/material.dart';

class LandingPrimaryButton extends StatelessWidget {
  const LandingPrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,

      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8A00), Color(0xFFFFB347)],

            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),

          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF8A00).withValues(alpha: 0.20),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ElevatedButton(
          onPressed: onPressed,

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,

            shadowColor: Colors.transparent,
            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(width: 10),

              Icon(icon, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
