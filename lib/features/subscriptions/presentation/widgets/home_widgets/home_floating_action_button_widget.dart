import 'package:flutter/material.dart';

class HomeFloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onAddSubscriptionPressed;
  final Color orangeColor;

  const HomeFloatingActionButtonWidget({
    super.key,
    required this.onAddSubscriptionPressed,
    required this.orangeColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onAddSubscriptionPressed,
      backgroundColor: orangeColor,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: const CircleBorder(),
      child: const Icon(Icons.add_rounded, size: 28),
    );
  }
}
