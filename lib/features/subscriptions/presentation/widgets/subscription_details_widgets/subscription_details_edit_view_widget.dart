import 'package:flutter/material.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_custom_date_field_widget.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_custom_dropdown_widget.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_custom_text_field_widget.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_section_title_widget.dart';

import '../../../domain/entity/subscription_entity.dart';
import '../../pages/subscription_details_page.dart';

class EditView extends StatelessWidget {
  const EditView({
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.notesController,
    required this.billingCycle,
    required this.status,
    required this.nextRenewalDate,
    required this.isLoading,
    required this.onBillingCycleChanged,
    required this.onStatusChanged,
    required this.onSelectRenewalDate,
    required this.onSavePressed,
    required this.formatDate,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController notesController;

  final BillingCycle billingCycle;
  final SubscriptionStatus status;
  final DateTime nextRenewalDate;

  final bool isLoading;

  final ValueChanged<BillingCycle?> onBillingCycleChanged;
  final ValueChanged<SubscriptionStatus?> onStatusChanged;

  final VoidCallback onSelectRenewalDate;
  final VoidCallback onSavePressed;

  final String Function(DateTime) formatDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),

      child: Form(
        key: formKey,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Subscription information'),

            const SizedBox(height: 18),

            CustomTextField(
              controller: nameController,
              label: 'Subscription name',
              hint: 'Enter subscription name',
              icon: Icons.subscriptions_outlined,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter subscription name';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller: priceController,
              label: 'Price',
              hint: 'Enter price',
              icon: Icons.payments_outlined,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter price';
                }

                final price = double.tryParse(value.trim());

                if (price == null || price < 0) {
                  return 'Please enter a valid price';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            const SectionTitle(title: 'Billing'),

            const SizedBox(height: 16),

            CustomDropdown<BillingCycle>(
              label: 'Billing cycle',
              value: billingCycle,
              icon: Icons.repeat_rounded,
              items: BillingCycle.values,
              itemLabel: (value) {
                switch (value) {
                  case BillingCycle.monthly:
                    return 'Monthly';

                  case BillingCycle.yearly:
                    return 'Yearly';
                }
              },
              onChanged: onBillingCycleChanged,
            ),

            const SizedBox(height: 16),

            CustomDateField(
              label: 'Next renewal date',
              value: formatDate(nextRenewalDate),
              onPressed: onSelectRenewalDate,
            ),

            const SizedBox(height: 16),

            CustomDropdown<SubscriptionStatus>(
              label: 'Status',
              value: status,
              icon: Icons.toggle_on_outlined,
              items: SubscriptionStatus.values,
              itemLabel: (value) {
                switch (value) {
                  case SubscriptionStatus.active:
                    return 'Active';

                  case SubscriptionStatus.cancelled:
                    return 'Cancelled';
                }
              },
              onChanged: onStatusChanged,
            ),

            const SizedBox(height: 24),

            const SectionTitle(title: 'Additional notes'),

            const SizedBox(height: 16),

            CustomTextField(
              controller: notesController,
              label: 'Notes',
              hint: 'Add notes (optional)',
              icon: Icons.notes_outlined,
              maxLines: 4,
            ),

            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton(
                onPressed: isLoading ? null : onSavePressed,

                style: ElevatedButton.styleFrom(
                  backgroundColor: SubscriptionDetailsPageState.primaryOrange,
                  disabledBackgroundColor: SubscriptionDetailsPageState
                      .primaryOrange
                      .withValues(alpha: 0.45),
                  foregroundColor: Colors.white,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: OutlinedButton(
                onPressed: isLoading ? null : () => Navigator.maybePop(context),

                style: OutlinedButton.styleFrom(
                  foregroundColor: SubscriptionDetailsPageState.secondaryText,

                  side: const BorderSide(
                    color: SubscriptionDetailsPageState.borderColor,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
