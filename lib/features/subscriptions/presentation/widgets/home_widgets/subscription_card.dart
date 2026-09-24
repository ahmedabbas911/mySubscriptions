import 'package:flutter/material.dart';

import '../../../domain/entity/subscription_entity.dart';
import '../../pages/subscription_details_page.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final SubscriptionEntity subscription;

  const SubscriptionCardWidget({super.key, required this.subscription});

  // ============================================================
  // Colors
  // ============================================================

  static const cardColor = Color(0xFF11171D);
  static const borderColor = Color(0xFF29333D);

  static const primaryOrange = Color(0xFFFF8500);
  static const primaryText = Color(0xFFF5F5F5);
  static const secondaryText = Color(0xFF8D98A5);

  static const activeColor = Color(0xFF20D897);
  static const cancelledColor = Color(0xFFFF6874);

  // ============================================================
  // Helpers
  // ============================================================

  bool _isArabic(String text) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  String _formatPrice(double price) {
    return 'EGP ${price.toStringAsFixed(2)}';
  }

  String _billingCycleLabel() {
    switch (subscription.billingCycle) {
      case BillingCycle.monthly:
        return 'Monthly';

      case BillingCycle.yearly:
        return 'Yearly';
    }
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isActive = subscription.status == SubscriptionStatus.active;

    final isNameArabic = _isArabic(subscription.name);

    final renewalDate = _formatDate(subscription.nextRenewalDate);

    final statusText = subscription.status.name.isNotEmpty
        ? subscription.status.name[0].toUpperCase() +
              subscription.status.name.substring(1)
        : 'Unknown';

    final statusColor = isActive ? activeColor : cancelledColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1),
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(18),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SubscriptionDetailsPage(subscription: subscription),
              ),
            );
          },

          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ==================================================
                // Name + Status
                // ==================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        subscription.name,

                        textDirection: isNameArabic
                            ? TextDirection.rtl
                            : TextDirection.ltr,

                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          color: primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.10),

                        borderRadius: BorderRadius.circular(8),

                        border: Border.all(
                          color: statusColor.withValues(alpha: 0.30),
                        ),
                      ),

                      child: Text(
                        statusText,

                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // ==================================================
                // Price
                // ==================================================
                Text(
                  _formatPrice(subscription.price),

                  style: const TextStyle(
                    color: primaryOrange,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 15),

                // ==================================================
                // Divider
                // ==================================================
                Container(height: 1, color: borderColor),

                const SizedBox(height: 13),

                // ==================================================
                // Renewal + Billing Cycle
                // ==================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: _InfoItem(
                        label: 'Next renewal',
                        value: renewalDate,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _InfoItem(
                        label: 'Billing cycle',
                        value: _billingCycleLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =================================================================
// Info Item
// =================================================================

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final TextAlign textAlign;

  const _InfoItem({
    required this.label,
    required this.value,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final isEndAligned = textAlign == TextAlign.end;

    return Column(
      crossAxisAlignment: isEndAligned
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,

      children: [
        Text(
          label,

          textAlign: textAlign,

          style: const TextStyle(
            color: Color(0xFF8D98A5),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,

          textAlign: textAlign,

          maxLines: 2,
          overflow: TextOverflow.ellipsis,

          style: const TextStyle(
            color: Color(0xFFDCE2E8),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
