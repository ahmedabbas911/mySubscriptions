import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../cubit/subscription_cubit.dart';
import '../cubit/subscription_state.dart';
import '../widgets/home_widgets/home_app_bar_widget.dart';
import '../widgets/home_widgets/home_empty_state.dart';
import '../widgets/home_widgets/home_error_state.dart';
import '../widgets/home_widgets/home_floating_action_button_widget.dart';
import '../widgets/home_widgets/home_loading_widget.dart';
import '../widgets/home_widgets/home_section_header_widget.dart';
import '../widgets/home_widgets/home_summary_card_widget.dart';
import '../widgets/home_widgets/subscription_card.dart';
import 'add_subscription_page.dart';

class SubscriptionsHomePage extends StatefulWidget {
  const SubscriptionsHomePage({super.key});

  @override
  State<SubscriptionsHomePage> createState() => _SubscriptionsHomePageState();
}

class _SubscriptionsHomePageState extends State<SubscriptionsHomePage> {
  // ============================================================
  // Theme Colors
  // ============================================================

  static const backgroundColor = Color(0xFF080D12);
  static const surfaceColor = Color(0xFF11171D);
  static const orangeColor = Color(0xFFFF8500);
  static const secondaryTextColor = Color(0xFF8D98A5);

  static const primaryTextColor = Color(0xFFF5F5F5);

  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void initState() {
    super.initState();

    try {
      context.read<SubscriptionCubit>().loadSubscriptions();
    } catch (_) {}
  }

  // ============================================================
  // Navigation
  // ============================================================

  void onAddSubscriptionPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddSubscriptionPage()),
    );
  }

  void onLogoutPressed() {
    context.read<AuthCubit>().logout();
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthInitialState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,

        appBar: HomeAppBarWidget(
          backgroundColor: backgroundColor,
          primaryTextColor: primaryTextColor,
          surfaceColor: surfaceColor,
          onLogoutPressed: onLogoutPressed,
        ),

        // ========================================================
        // Body
        // ========================================================
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
            builder: (context, state) {
              // ====================================================
              // Loading
              // ====================================================

              if (state is SubscriptionLoadingState) {
                return HomeLoadingWidget(orangeColor: orangeColor);
              }

              // ====================================================
              // Empty State
              // ====================================================

              if (state is SubscriptionEmptyState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: HomeEmptyStateWidget(
                      onAddPressed: onAddSubscriptionPressed,
                    ),
                  ),
                );
              }

              // ====================================================
              // Error State
              // ====================================================

              if (state is SubscriptionErrorState) {
                return HomeErrorWidget(errorMessage: state.errorMessage);
              }

              // ====================================================
              // Success State
              // ====================================================

              if (state is SubscriptionSuccessState) {
                final subscriptions = state.subscriptions;

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // ==================================================
                    // Header
                    // ==================================================
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Summary Card
                            SummaryCard(subscriptions: subscriptions),

                            const SizedBox(height: 28),

                            // Section Header
                            HomeSectionHeaderWidget(
                              subscriptionsCount: subscriptions.length,
                              primaryTextColor: primaryTextColor,
                              secondaryTextColor: secondaryTextColor,
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),

                    // ==================================================
                    // Subscriptions List
                    // ==================================================
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SubscriptionCardWidget(
                              subscription: subscriptions[index],
                            ),
                          );
                        }, childCount: subscriptions.length),
                      ),
                    ),
                  ],
                );
              }

              // ====================================================
              // Default State
              // ====================================================

              return const Center(
                child: Text(
                  'Welcome to My Subscriptions',
                  style: TextStyle(color: primaryTextColor, fontSize: 16),
                ),
              );
            },
          ),
        ),

        // ========================================================
        // Floating Action Button
        // ========================================================
        floatingActionButton: HomeFloatingActionButtonWidget(
          onAddSubscriptionPressed: onAddSubscriptionPressed,
          orangeColor: orangeColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
