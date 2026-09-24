import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../subscriptions/presentation/pages/subscriptions_home_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_gate_widgets/auth_gate_loading_widget.dart';
import 'login_page.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  // ============================================================
  // Theme Colors
  // ============================================================

  static const backgroundColor = Color(0xFF0B0D12);
  static const primaryOrange = Color(0xFFFF8A00);
  static const primaryTextColor = Color(0xFFF5F5F5);
  static const secondaryTextColor = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscriptionsHomePage(),
            ),
            (route) => false,
          );
        } else if (state is AuthInitialState || state is AuthError) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      },

      builder: (context, state) {
        if (state is AuthSuccess) {
          return const SubscriptionsHomePage();
        } else if (state is AuthInitialState || state is AuthError) {
          return const LoginPage();
        }

        return const AuthGateLoadingWidget();
      },
    );
  }
}
