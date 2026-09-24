import 'package:flutter/material.dart';

import '../../pages/subscription_details_page.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({
    required this.label,
    required this.value,
    required this.onPressed,
  });

  final String label;
  final String value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          label,
          style: TextStyle(
            color: SubscriptionDetailsPageState.primaryText,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 9),

        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),

          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),

            decoration: BoxDecoration(
              color: SubscriptionDetailsPageState.fieldColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: SubscriptionDetailsPageState.borderColor,
              ),
            ),

            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: SubscriptionDetailsPageState.secondaryText,
                  size: 20,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: SubscriptionDetailsPageState.primaryText,
                      fontSize: 14,
                    ),
                  ),
                ),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: SubscriptionDetailsPageState.secondaryText,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
