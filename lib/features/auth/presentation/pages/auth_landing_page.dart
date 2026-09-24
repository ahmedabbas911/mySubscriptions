import 'package:flutter/material.dart';

import '../widgets/auth_landing_widgets/auth_landing_background_glow_widget.dart';
import '../widgets/auth_landing_widgets/auth_landing_feature_card_widget.dart';
import '../widgets/auth_landing_widgets/auth_landing_header_widget.dart';
import '../widgets/auth_landing_widgets/auth_landing_primary_button_widget.dart';
import '../widgets/auth_landing_widgets/auth_landing_secondary_button_widget.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  // ============================================================
  // Theme Colors
  // ============================================================

  static const backgroundColor = Color(0xFF0B0D12);
  static const cardColor = Color(0xFF191C24);

  static const primaryOrange = Color(0xFFFF8A00);
  static const lightOrange = Color(0xFFFFB347);

  static const primaryTextColor = Color(0xFFF5F5F5);
  static const secondaryTextColor = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: Stack(
        children: [
          // ======================================================
          // Background Orange Glows
          // ======================================================
          const Positioned(
            top: -120,
            left: -120,
            child: LandingBackgroundGlow(color: Color(0x32FF8A00), size: 340),
          ),

          const Positioned(
            bottom: -150,
            right: -120,
            child: LandingBackgroundGlow(color: Color(0x22FF6B00), size: 360),
          ),

          // ======================================================
          // Main Content
          // ======================================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),

              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // ==================================================
                  // Header
                  // ==================================================
                  const AuthLandingHeaderWidget(),

                  const Spacer(flex: 2),

                  // ==================================================
                  // Feature Card
                  // ==================================================
                  const AuthLandingFeatureCardWidget(),

                  const SizedBox(height: 30),

                  // ==================================================
                  // Sign In Button
                  // ==================================================
                  LandingPrimaryButton(
                    label: 'Sign In',
                    icon: Icons.arrow_forward_rounded,

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  // ==================================================
                  // Create Account Button
                  // ==================================================
                  LandingSecondaryButton(
                    label: 'Create an Account',

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // Footer
                  // ==================================================
                  const Text(
                    'Your subscriptions, beautifully organized.',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
