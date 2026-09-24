import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../subscriptions/presentation/pages/subscriptions_home_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/login_widgets/forgot_password_dialog_widget.dart';
import '../widgets/login_widgets/login_background_glow_widget.dart';
import '../widgets/login_widgets/login_card_widget.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ============================================================
  // Controllers & Form
  // ============================================================

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordObscured = true;

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

    super.dispose();
  }

  // ============================================================
  // Authentication
  // ============================================================

  void onLoginPressed() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
        emailController.text.trim(),
        passwordController.text,
      );
    }
  }

  Future<void> onForgotPasswordPressed() async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return ForgotPasswordDialogWidget(
          initialEmail: emailController.text.trim(),
        );
      },
    );
  }

  void onSignUpPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
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
          // Background
          // ======================================================
          const Positioned(
            top: -160,
            left: -140,
            child: BackgroundGlow(color: Color(0x22FF8A00), size: 360),
          ),

          const Positioned(
            bottom: -180,
            right: -140,
            child: BackgroundGlow(color: Color(0x18FF6B00), size: 380),
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
                      content: Text(state.errorMessage ?? 'Failed to sign in'),
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

                    child: LoginCard(
                      formKey: formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                      isLoading: isLoading,
                      isPasswordObscured: isPasswordObscured,

                      onPasswordVisibilityChanged: () {
                        setState(() {
                          isPasswordObscured = !isPasswordObscured;
                        });
                      },

                      onLoginPressed: onLoginPressed,
                      onForgotPasswordPressed: onForgotPasswordPressed,
                      onSignUpPressed: onSignUpPressed,
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
