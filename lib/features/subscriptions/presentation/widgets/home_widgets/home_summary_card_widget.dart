import 'package:flutter/cupertino.dart';

import '../../../domain/entity/subscription_entity.dart';

class SummaryCard extends StatelessWidget {
  final List<SubscriptionEntity> subscriptions;

  const SummaryCard({required this.subscriptions});

  double get totalSubscriptionsPrice {
    return subscriptions.fold<double>(0, (total, subscription) {
      return total + subscription.price;
    });
  }

  int get activeSubscriptionsCount {
    return subscriptions
        .where(
          (subscription) => subscription.status == SubscriptionStatus.active,
        )
        .length;
  }

  String formatPrice(double price) {
    return 'EGP ${price.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF11171D),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFF8500).withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total subscriptions cost',
            style: TextStyle(
              color: Color(0xFF9BA5B2),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            formatPrice(totalSubscriptionsPrice),
            style: const TextStyle(
              color: Color(0xFFFF8500),
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                '${subscriptions.length} total subscriptions',
                style: const TextStyle(color: Color(0xFF9BA5B2), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
