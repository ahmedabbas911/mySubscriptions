import 'package:flutter/material.dart';
import 'package:my_subscriptions/features/auth/presentation/widgets/register_widgets/register_icon_widget.dart';
import 'package:my_subscriptions/features/auth/presentation/widgets/register_widgets/register_sign_up_button_widget.dart';
import 'package:my_subscriptions/features/auth/presentation/widgets/register_widgets/register_text_field_widget.dart';

class RegisterCard extends StatelessWidget {
  const RegisterCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.isPasswordObscured,
    required this.isConfirmPasswordObscured,
    required this.onPasswordVisibilityChanged,
    required this.onConfirmPasswordVisibilityChanged,
    required this.onRegisterPressed,
    required this.onSignInPressed,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final bool isLoading;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;

  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onConfirmPasswordVisibilityChanged;
  final VoidCallback onRegisterPressed;
  final VoidCallback onSignInPressed;

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
            // Register Icon
            // ====================================================
            const RegisterIcon(),

            const SizedBox(height: 24),

            // ====================================================
            // Title
            // ====================================================
            const Text(
              'Create Account',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Create an account to manage your subscriptions',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // ====================================================
            // Email
            // ====================================================
            RegisterTextField(
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
            RegisterTextField(
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

            const SizedBox(height: 16),

            // ====================================================
            // Confirm Password
            // ====================================================
            RegisterTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              prefixIcon: Icons.lock_outline,
              obscureText: isConfirmPasswordObscured,

              suffixIcon: IconButton(
                onPressed: onConfirmPasswordVisibilityChanged,

                icon: Icon(
                  isConfirmPasswordObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,

                  color: const Color(0xFF9CA3AF),
                  size: 20,
                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }

                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),

            const SizedBox(height: 28),

            // ====================================================
            // Sign Up Button
            // ====================================================
            SignUpButton(isLoading: isLoading, onPressed: onRegisterPressed),

            const SizedBox(height: 26),

            // ====================================================
            // Sign In
            // ====================================================
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',

                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                ),

                GestureDetector(
                  onTap: isLoading ? null : onSignInPressed,

                  child: const Text(
                    'Sign In',

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
