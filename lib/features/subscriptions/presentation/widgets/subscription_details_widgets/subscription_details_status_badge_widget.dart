import 'package:flutter/cupertino.dart';

import '../../../domain/entity/subscription_entity.dart';
import '../../pages/subscription_details_page.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, required this.label});

  final SubscriptionStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isActive = status == SubscriptionStatus.active;

    final color = isActive
        ? SubscriptionDetailsPageState.successColor
        : SubscriptionDetailsPageState.secondaryText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),

      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,

            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),

          const SizedBox(width: 8),

          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
