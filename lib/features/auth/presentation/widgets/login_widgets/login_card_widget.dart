import 'package:flutter/material.dart';

import 'login_icon_widget.dart';
import 'login_sign_in_button_widget.dart';
import 'login_text_field_widget.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.isPasswordObscured,
    required this.onPasswordVisibilityChanged,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onSignUpPressed,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool isLoading;
  final bool isPasswordObscured;

  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignUpPressed;

  static const primaryOrange = Color(0xFFFF8A00);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),

      decoration: BoxDecoration(
        color: const Color(0xFF191C24),

        borderRadius: BorderRadius.circular(28),

        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Form(
        key: formKey,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ====================================================
            // Lock Icon
            // ====================================================
            const LoginIcon(),

            const SizedBox(height: 24),

            // ====================================================
            // Welcome Text
            // ====================================================
            const Text(
              'Welcome Back',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 27,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Sign in to manage your subscriptions',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            // ====================================================
            // Email
            // ====================================================
            LoginTextField(
              controller: emailController,
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }

                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            // ====================================================
            // Password
            // ====================================================
            LoginTextField(
              controller: passwordController,
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              obscureText: isPasswordObscured,

              suffixIcon: IconButton(
                onPressed: onPasswordVisibilityChanged,

                icon: Icon(
                  isPasswordObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,

                  color: const Color(0xFF9CA3AF),
                  size: 20,
                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            // ====================================================
            // Forgot Password
            // ====================================================
            Align(
              alignment: Alignment.centerRight,

              child: TextButton(
                onPressed: isLoading ? null : onForgotPasswordPressed,

                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 4,
                  ),

                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),

                child: const Text(
                  'Forgot Password?',

                  style: TextStyle(
                    color: Color(0xFFFFB347),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ====================================================
            // Sign In Button
            // ====================================================
            SignInButton(isLoading: isLoading, onPressed: onLoginPressed),

            const SizedBox(height: 26),

            // ====================================================
            // Sign Up
            // ====================================================
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",

                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                ),

                GestureDetector(
                  onTap: isLoading ? null : onSignUpPressed,

                  child: const Text(
                    'Sign Up',

                    style: TextStyle(
                      color: Color(0xFFFFB347),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
