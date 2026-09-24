import 'package:flutter/material.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_info_tile_widget.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_notes_tile_widget.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_section_title_widget.dart';
import 'package:my_subscriptions/features/subscriptions/presentation/widgets/subscription_details_widgets/subscription_details_status_badge_widget.dart';

import '../../../domain/entity/subscription_entity.dart';
import '../../pages/subscription_details_page.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    required this.subscription,
    required this.isArabicName,
    required this.billingCycleLabel,
    required this.statusLabel,
    required this.formatDate,
    required this.formatPrice,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.isDeleting,
  });

  final SubscriptionEntity subscription;
  final bool isArabicName;
  final String billingCycleLabel;
  final String statusLabel;

  final String Function(DateTime) formatDate;
  final String Function(double) formatPrice;

  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========================================================
          // Main Subscription Header
          // ========================================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: SubscriptionDetailsPageState.surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: SubscriptionDetailsPageState.borderColor,
              ),
            ),

            child: Column(
              children: [
                // Subscription Name
                Text(
                  subscription.name,
                  textAlign: TextAlign.center,
                  textDirection: isArabicName
                      ? TextDirection.rtl
                      : TextDirection.ltr,

                  style: TextStyle(
                    color: SubscriptionDetailsPageState.primaryText,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 10),

                // Category
                Text(
                  subscription.category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: SubscriptionDetailsPageState.secondaryText,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),

                // Price
                Text(
                  formatPrice(subscription.price),
                  style: const TextStyle(
                    color: SubscriptionDetailsPageState.primaryOrange,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                  ),
                ),

                const SizedBox(height: 16),

                // Billing Cycle Label
                Text(
                  'per ${billingCycleLabel.toLowerCase()}',
                  style: TextStyle(
                    color: SubscriptionDetailsPageState.secondaryText,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 18),

                // Status
                StatusBadge(status: subscription.status, label: statusLabel),
              ],
            ),
          ),

          const SizedBox(height: 26),

          // ========================================================
          // Renewal Section
          // ========================================================
          const SectionTitle(title: 'Renewal'),

          const SizedBox(height: 12),

          // Next Renewal
          DetailsInfoTile(
            title: 'Next renewal',
            value: formatDate(subscription.nextRenewalDate),
          ),

          const SizedBox(height: 10),

          // Billing Cycle
          DetailsInfoTile(title: 'Billing cycle', value: billingCycleLabel),

          // ========================================================
          // Notes
          // ========================================================
          if (subscription.notes != null &&
              subscription.notes!.trim().isNotEmpty) ...[
            const SizedBox(height: 10),

            NotesTile(notes: subscription.notes!),
          ],

          const SizedBox(height: 28),

          // ========================================================
          // Edit Button
          // ========================================================
          SizedBox(
            width: double.infinity,
            height: 56,

            child: ElevatedButton(
              onPressed: isDeleting ? null : onEditPressed,

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

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_outlined, size: 19),
                  SizedBox(width: 10),
                  Text(
                    'Edit Subscription',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ========================================================
          // Delete Button
          // ========================================================
          SizedBox(
            width: double.infinity,
            height: 56,

            child: OutlinedButton(
              onPressed: isDeleting ? null : onDeletePressed,

              style: OutlinedButton.styleFrom(
                foregroundColor: SubscriptionDetailsPageState.deleteColor,
                disabledForegroundColor: SubscriptionDetailsPageState
                    .deleteColor
                    .withValues(alpha: 0.45),

                side: BorderSide(
                  color: SubscriptionDetailsPageState.deleteColor.withValues(
                    alpha: 0.65,
                  ),
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              child: isDeleting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: SubscriptionDetailsPageState.deleteColor,
                        strokeWidth: 2,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_outline_rounded, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Delete Subscription',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
