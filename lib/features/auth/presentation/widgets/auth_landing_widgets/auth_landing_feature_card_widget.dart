import 'package:flutter/material.dart';

class AuthLandingFeatureCardWidget extends StatelessWidget {
  const AuthLandingFeatureCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF8B7CFF).withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF8B7CFF).withValues(alpha: 0.20),
              ),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 20,
              color: Color(0xFFB7ACFF),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Stay organized. Stay in control.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.80),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
