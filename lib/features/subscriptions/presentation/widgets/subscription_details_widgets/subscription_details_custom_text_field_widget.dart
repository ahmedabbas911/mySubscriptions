import 'package:flutter/material.dart';

import '../../pages/subscription_details_page.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
  });

  final TextEditingController controller;

  final String label;
  final String hint;
  final IconData icon;

  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

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

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,

          style: TextStyle(
            color: SubscriptionDetailsPageState.primaryText,
            fontSize: 14,
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: SubscriptionDetailsPageState.secondaryText,
              fontSize: 13,
            ),

            prefixIcon: Icon(
              icon,
              color: SubscriptionDetailsPageState.secondaryText,
              size: 20,
            ),

            filled: true,
            fillColor: SubscriptionDetailsPageState.fieldColor,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
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

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: SubscriptionDetailsPageState.errorColor,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: SubscriptionDetailsPageState.errorColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
