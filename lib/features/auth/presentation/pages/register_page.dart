import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../subscriptions/presentation/pages/subscriptions_home_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/register_widgets/register_background_glow_widget.dart';
import '../widgets/register_widgets/register_card_widget.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ============================================================
  // Controllers & Form
  // ============================================================

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  // ============================================================
  // Theme Colors
  // ============================================================

  static const backgroundColor = Color(0xFF0B0D12);

  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // Registration
  // ============================================================

  void onRegisterPressed() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
        emailController.text.trim(),
        passwordController.text,
      );
    }
  }

  void onSignInPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: Stack(
        children: [
          // ======================================================
          // Background Glows
          // ======================================================
          const Positioned(
            top: -160,
            left: -140,
            child: RegisterBackgroundGlow(color: Color(0x22FF8A00), size: 360),
          ),

          const Positioned(
            bottom: -180,
            right: -140,
            child: RegisterBackgroundGlow(color: Color(0x18FF6B00), size: 380),
          ),

          // ======================================================
          // Main Content
          // ======================================================
          SafeArea(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionsHomePage(),
                    ),
                    (route) => false,
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'Failed to sign up'),
                      backgroundColor: Colors.red.shade700,
                    ),
                  );
                }
              },

              builder: (context, state) {
                final isLoading = state is AuthLoadingState;

                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),

                    child: RegisterCard(
                      formKey: formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      isLoading: isLoading,
                      isPasswordObscured: isPasswordObscured,
                      isConfirmPasswordObscured: isConfirmPasswordObscured,

                      onPasswordVisibilityChanged: () {
                        setState(() {
                          isPasswordObscured = !isPasswordObscured;
                        });
                      },

                      onConfirmPasswordVisibilityChanged: () {
                        setState(() {
                          isConfirmPasswordObscured =
                              !isConfirmPasswordObscured;
                        });
                      },

                      onRegisterPressed: onRegisterPressed,
                      onSignInPressed: onSignInPressed,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
