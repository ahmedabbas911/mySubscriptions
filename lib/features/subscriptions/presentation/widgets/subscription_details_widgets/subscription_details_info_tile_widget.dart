import 'package:flutter/cupertino.dart';

import '../../pages/subscription_details_page.dart';

class DetailsInfoTile extends StatelessWidget {
  const DetailsInfoTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      decoration: BoxDecoration(
        color: SubscriptionDetailsPageState.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SubscriptionDetailsPageState.borderColor),
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: SubscriptionDetailsPageState.secondaryText,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: SubscriptionDetailsPageState.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
