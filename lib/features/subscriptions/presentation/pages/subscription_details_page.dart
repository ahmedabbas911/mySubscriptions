import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/subscription_entity.dart';
import '../cubit/subscription_cubit.dart';
import '../cubit/subscription_state.dart';
import '../widgets/subscription_details_widgets/subscription_details_app_bar_widget.dart';
import '../widgets/subscription_details_widgets/subscription_details_edit_view_widget.dart';
import '../widgets/subscription_details_widgets/subscription_details_view_widget.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  final SubscriptionEntity subscription;

  const SubscriptionDetailsPage({super.key, required this.subscription});

  @override
  State<SubscriptionDetailsPage> createState() =>
      SubscriptionDetailsPageState();
}

class SubscriptionDetailsPageState extends State<SubscriptionDetailsPage> {
  // ============================================================
  // Theme
  // ============================================================

  static const backgroundColor = Color(0xFF0B0D12);
  static const surfaceColor = Color(0xFF15181F);
  static const fieldColor = Color(0xFF1B1F27);
  static const borderColor = Color(0xFF2A2F38);

  static const primaryOrange = Color(0xFFFF8A00);
  static const lightOrange = Color(0xFFFFB347);

  static const primaryText = Color(0xFFF5F5F5);
  static const secondaryText = Color(0xFF969DA9);
  static const successColor = Color(0xFF42B883);
  static const errorColor = Color(0xFFE05C68);
  static const deleteColor = Color(0xFFFF5C67);

  // ============================================================
  // State
  // ============================================================

  late SubscriptionEntity currentSubscription;

  bool isEditing = false;
  bool isSaving = false;
  bool isDeleting = false;

  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController notesController;

  late BillingCycle billingCycle;
  late SubscriptionStatus status;
  late DateTime nextRenewalDate;

  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void initState() {
    super.initState();

    currentSubscription = widget.subscription;
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController(text: currentSubscription.name);

    priceController = TextEditingController(
      text: currentSubscription.price.toString(),
    );

    notesController = TextEditingController(
      text: currentSubscription.notes ?? '',
    );

    billingCycle = currentSubscription.billingCycle;
    status = currentSubscription.status;
    nextRenewalDate = currentSubscription.nextRenewalDate;
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    notesController.dispose();

    super.dispose();
  }

  // ============================================================
  // Helpers
  // ============================================================

  bool isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  String formatDate(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  String formatPrice(double price) {
    return 'EGP ${price.toStringAsFixed(2)}';
  }

  String get billingCycleLabel {
    switch (billingCycle) {
      case BillingCycle.monthly:
        return 'Monthly';

      case BillingCycle.yearly:
        return 'Yearly';
    }
  }

  String get statusLabel {
    switch (status) {
      case SubscriptionStatus.active:
        return 'Active';

      case SubscriptionStatus.cancelled:
        return 'Cancelled';
    }
  }

  // ============================================================
  // Date Picker
  // ============================================================

  Future<void> selectNextRenewalDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: nextRenewalDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: primaryOrange,
              onPrimary: Colors.white,
              surface: surfaceColor,
              onSurface: primaryText,
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

  // ============================================================
  // Update Subscription
  // ============================================================

  void onSavePressed() {
    if (isSaving || isDeleting) return;

    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isSaving = true;
      });

      final updatedEntity = SubscriptionEntity(
        id: currentSubscription.id,
        name: nameController.text.trim(),
        price: double.parse(priceController.text.trim()),
        billingCycle: billingCycle,
        nextRenewalDate: nextRenewalDate,
        category: currentSubscription.category,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        status: status,
        userId: currentSubscription.userId,
      );

      context.read<SubscriptionCubit>().updateSubscription(updatedEntity);
    }
  }

  // ============================================================
  // Edit
  // ============================================================

  void toggleEditing() {
    setState(() {
      if (isEditing) {
        _resetEditingValues();
      }

      isEditing = !isEditing;
    });
  }

  void _resetEditingValues() {
    nameController.text = currentSubscription.name;

    priceController.text = currentSubscription.price.toString();

    notesController.text = currentSubscription.notes ?? '';

    billingCycle = currentSubscription.billingCycle;
    status = currentSubscription.status;
    nextRenewalDate = currentSubscription.nextRenewalDate;
  }

  // ============================================================
  // Delete Confirmation
  // ============================================================

  Future<void> confirmDeleteSubscription() async {
    if (isDeleting || isSaving) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Delete Subscription?',
            style: TextStyle(
              color: primaryText,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to delete '
            '"${currentSubscription.name}"? '
            'This action cannot be undone.',
            style: const TextStyle(
              color: secondaryText,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: deleteColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && mounted) {
      deleteSubscription();
    }
  }

  void deleteSubscription() {
    setState(() {
      isDeleting = true;
    });

    // Make sure your SubscriptionCubit has this method.
    context.read<SubscriptionCubit>().deleteSubscription(
      currentSubscription.id,
    );
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isNameArabic = isArabic(currentSubscription.name);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: DetailsAppBar(
        isEditing: isEditing,
        onBackPressed: () => Navigator.pop(context),
      ),

      body: SafeArea(
        child: BlocConsumer<SubscriptionCubit, SubscriptionState>(
          listener: handleSubscriptionState,

          builder: (context, state) {
            final isLoading =
                state is SubscriptionLoadingState && (isSaving || isDeleting);

            if (isEditing) {
              return EditView(
                formKey: formKey,
                nameController: nameController,
                priceController: priceController,
                notesController: notesController,
                billingCycle: billingCycle,
                status: status,
                nextRenewalDate: nextRenewalDate,
                isLoading: isLoading,
                onBillingCycleChanged: (newCycle) {
                  if (newCycle != null) {
                    setState(() {
                      billingCycle = newCycle;
                    });
                  }
                },
                onStatusChanged: (newStatus) {
                  if (newStatus != null) {
                    setState(() {
                      status = newStatus;
                    });
                  }
                },
                onSelectRenewalDate: selectNextRenewalDate,
                onSavePressed: onSavePressed,
                formatDate: formatDate,
              );
            }

            return DetailsView(
              subscription: currentSubscription,
              isArabicName: isNameArabic,
              billingCycleLabel: billingCycleLabel,
              statusLabel: statusLabel,
              formatDate: formatDate,
              formatPrice: formatPrice,
              onEditPressed: toggleEditing,
              onDeletePressed: confirmDeleteSubscription,
              isDeleting: isDeleting,
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // State Listener
  // ============================================================

  void handleSubscriptionState(BuildContext context, SubscriptionState state) {
    if (!isSaving && !isDeleting) return;

    if (state is SubscriptionSuccessState) {
      if (isDeleting) {
        Navigator.pop(context);
        return;
      }

      final updated = state.subscriptions.firstWhere(
        (subscription) => subscription.id == currentSubscription.id,
        orElse: () => currentSubscription,
      );

      setState(() {
        currentSubscription = updated;
        isEditing = false;
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_outline_rounded, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Subscription updated successfully!')),
            ],
          ),
          backgroundColor: successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
    } else if (state is SubscriptionEmptyState) {
      if (isDeleting) {
        Navigator.pop(context);
        return;
      }

      setState(() {
        isSaving = false;
      });
    } else if (state is SubscriptionErrorState) {
      setState(() {
        isSaving = false;
        isDeleting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage),
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
