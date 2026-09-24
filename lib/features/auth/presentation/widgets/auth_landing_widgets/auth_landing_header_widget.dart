import 'package:flutter/material.dart';

class AuthLandingHeaderWidget extends StatelessWidget {
  const AuthLandingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 108,
          height: 108,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.white.withValues(alpha: 0.07),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B7CFF).withValues(alpha: 0.20),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF9C8BFF), Color(0xFF5541D8)],
              ),
            ),
            child: const Icon(
              Icons.subscriptions_outlined,
              size: 48,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'My Subscriptions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Track and manage all your recurring subscriptions in one place.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}
