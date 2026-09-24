import 'package:flutter/cupertino.dart';

import '../../pages/subscription_details_page.dart';

class NotesTile extends StatelessWidget {
  const NotesTile({required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: SubscriptionDetailsPageState.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SubscriptionDetailsPageState.borderColor),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notes',
            style: TextStyle(
              color: SubscriptionDetailsPageState.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            notes,
            style: TextStyle(
              color: SubscriptionDetailsPageState.primaryText,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
