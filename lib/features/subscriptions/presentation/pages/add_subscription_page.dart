import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/subscription_entity.dart';
import '../cubit/subscription_cubit.dart';
import '../cubit/subscription_state.dart';
import '../widgets/add_subscription_widgets/add_subscription_app_text_field_widget.dart';
import '../widgets/add_subscription_widgets/add_subscription_billing_cycle_selector_widget.dart';
import '../widgets/add_subscription_widgets/add_subscription_date_selector_widget.dart';
import '../widgets/add_subscription_widgets/add_subscription_field_label_widget.dart';
import '../widgets/add_subscription_widgets/add_subscription_page_header_widget.dart';
import '../widgets/add_subscription_widgets/add_subscription_save_button_widget.dart';
import '../widgets/add_subscription_widgets/add_subscription_section_card_widget.dart';

class AddSubscriptionPage extends StatefulWidget {
  const AddSubscriptionPage({super.key});

  @override
  State<AddSubscriptionPage> createState() => AddSubscriptionPageState();
}

class AddSubscriptionPageState extends State<AddSubscriptionPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final notesController = TextEditingController();

  BillingCycle billingCycle = BillingCycle.monthly;
  SubscriptionStatus status = SubscriptionStatus.active;

  DateTime nextRenewalDate = DateTime.now().add(const Duration(days: 30));

  bool isSubmitting = false;

  static const backgroundColor = Color(0xFF090D12);
  static const cardColor = Color(0xFF131A21);
  static const inputColor = Color(0xFF10161C);
  static const borderColor = Color(0xFF29333D);
  static const orangeColor = Color(0xFFFF8500);
  static const textColor = Color(0xFFF5F7FA);
  static const secondaryTextColor = Color(0xFF929DA8);
  static const errorColor = Color(0xFFE05252);

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> selectNextRenewalDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: nextRenewalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: orangeColor,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: textColor,
            ),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: cardColor,
              headerBackgroundColor: orangeColor,
              headerForegroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        nextRenewalDate = pickedDate;
      });
    }
  }

  void onSavePressed() {
    if (isSubmitting) return;

    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isSubmitting = true;
      });

      final subscription = SubscriptionEntity(
        id: '',
        name: nameController.text.trim(),
        price: double.parse(priceController.text.trim()),
        billingCycle: billingCycle,
        nextRenewalDate: nextRenewalDate,
        category: 'General',
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        status: status,
        userId: '',
      );

      context.read<SubscriptionCubit>().addSubscription(subscription);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: textColor,
            size: 25,
          ),
        ),
        title: const Text(
          'Add Subscription',
          style: TextStyle(
            color: textColor,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
          listener: handleSubscriptionState,
          builder: (context, state) {
            final isLoading = state is SubscriptionLoadingState && isSubmitting;

            return Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  const PageHeader(),

                  const SizedBox(height: 24),

                  SubscriptionSectionCard(
                    icon: Icons.description_outlined,
                    title: 'Basic information',
                    subtitle: 'Tell us about your subscription',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldLabel(label: 'Subscription name'),
                        const SizedBox(height: 10),
                        AppTextField(
                          controller: nameController,
                          hintText: 'e.g. Netflix',
                          prefixIcon: Icons.account_balance_wallet_outlined,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a subscription name';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  SubscriptionSectionCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Price',
                    subtitle: 'How much do you pay?',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FieldLabel(label: 'Subscription price'),
                        const SizedBox(height: 10),
                        AppTextField(
                          controller: priceController,
                          hintText: '0.00',
                          prefixIcon: Icons.payments_outlined,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textInputAction: TextInputAction.next,
                          suffixText: 'EGP',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a price';
                            }

                            final price = double.tryParse(value.trim());

                            if (price == null || price < 0) {
                              return 'Enter a valid price';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  SubscriptionSectionCard(
                    icon: Icons.sync_rounded,
                    title: 'Billing cycle',
                    subtitle: 'How often do you pay?',
                    child: BillingCycleSelector(
                      selectedCycle: billingCycle,
                      onChanged: (newCycle) {
                        setState(() {
                          billingCycle = newCycle;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  SubscriptionSectionCard(
                    icon: Icons.calendar_month_outlined,
                    title: 'Next renewal',
                    subtitle: 'When will you be charged next?',
                    child: DateSelector(
                      formattedDate: formatDate(nextRenewalDate),
                      onTap: selectNextRenewalDate,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SubscriptionSectionCard(
                    icon: Icons.notes_outlined,
                    title: 'Additional notes',
                    subtitle: 'Add any extra details (optional)',
                    child: AppTextField(
                      controller: notesController,
                      hintText: 'e.g. Family plan, personal account...',
                      prefixIcon: Icons.sticky_note_2_outlined,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),

                  const SizedBox(height: 24),

                  SaveButton(isLoading: isLoading, onPressed: onSavePressed),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void handleSubscriptionState(BuildContext context, SubscriptionState state) {
    if (!isSubmitting) return;

    if (state is SubscriptionSuccessState || state is SubscriptionEmptyState) {
      setState(() {
        isSubmitting = false;
      });

      Navigator.pop(context);
    } else if (state is SubscriptionErrorState) {
      setState(() {
        isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text(state.errorMessage)),
            ],
          ),
          backgroundColor: errorColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
    }
  }
}
