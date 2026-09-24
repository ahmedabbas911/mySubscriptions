import 'package:flutter/material.dart';

import '../../pages/auth_gate_page.dart';
import 'auth_gate_background_glow_widget.dart';

class AuthGateLoadingWidget extends StatelessWidget {
  const AuthGateLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthGatePage.backgroundColor,

      body: Stack(
        children: [
          // ========================================================
          // Background Glows
          // ========================================================
          const Positioned(
            top: -180,
            left: -150,
            child: AuthGateBackgroundGlow(color: Color(0x24FF8A00), size: 380),
          ),

          const Positioned(
            bottom: -180,
            right: -150,
            child: AuthGateBackgroundGlow(color: Color(0x16FF6B00), size: 380),
          ),

          // ========================================================
          // Loading Content
          // ========================================================
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ==================================================
                  // App Icon
                  // ==================================================
                  Container(
                    width: 80,
                    height: 80,

                    decoration: BoxDecoration(
                      color: AuthGatePage.primaryOrange,
                      borderRadius: BorderRadius.circular(24),

                      boxShadow: [
                        BoxShadow(
                          color: AuthGatePage.primaryOrange.withValues(
                            alpha: 0.20,
                          ),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // App Name
                  // ==================================================
                  const Text(
                    'My Subscriptions',

                    style: TextStyle(
                      color: AuthGatePage.primaryTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ==================================================
                  // Loading Text
                  // ==================================================
                  const Text(
                    'Checking your account...',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: AuthGatePage.secondaryTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // Loading Indicator
                  // ==================================================
                  const SizedBox(
                    width: 26,
                    height: 26,

                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AuthGatePage.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
