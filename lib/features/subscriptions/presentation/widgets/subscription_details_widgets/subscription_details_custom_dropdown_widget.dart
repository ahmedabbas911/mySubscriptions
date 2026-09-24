import 'package:flutter/material.dart';

import '../../pages/subscription_details_page.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    required this.label,
    required this.value,
    required this.icon,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  final String label;
  final T value;
  final IconData icon;
  final List<T> items;

  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

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

        DropdownButtonFormField<T>(
          initialValue: value,
          dropdownColor: SubscriptionDetailsPageState.surfaceColor,
          iconEnabledColor: SubscriptionDetailsPageState.secondaryText,
          onChanged: onChanged,

          style: const TextStyle(
            color: SubscriptionDetailsPageState.primaryText,
            fontSize: 14,
          ),

          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: SubscriptionDetailsPageState.secondaryText,
              size: 20,
            ),

            filled: true,
            fillColor: SubscriptionDetailsPageState.fieldColor,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: SubscriptionDetailsPageState.borderColor,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: SubscriptionDetailsPageState.borderColor,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: SubscriptionDetailsPageState.primaryOrange,
                width: 1.2,
              ),
            ),
          ),

          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
