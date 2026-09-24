import 'package:flutter/material.dart';

class HomeSectionHeaderWidget extends StatelessWidget {
  final int subscriptionsCount;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  const HomeSectionHeaderWidget({
    super.key,
    required this.subscriptionsCount,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Your subscriptions',
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        Text(
          '$subscriptionsCount total',
          style: TextStyle(color: secondaryTextColor, fontSize: 12),
        ),
      ],
    );
  }
}
