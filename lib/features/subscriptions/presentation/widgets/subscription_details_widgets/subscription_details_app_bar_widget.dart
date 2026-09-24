import 'package:flutter/material.dart';

import '../../pages/subscription_details_page.dart';

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailsAppBar({required this.isEditing, required this.onBackPressed});

  final bool isEditing;
  final VoidCallback onBackPressed;

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: SubscriptionDetailsPageState.backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,

      leading: IconButton(
        onPressed: onBackPressed,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: SubscriptionDetailsPageState.primaryText,
          size: 19,
        ),
      ),

      title: Text(
        isEditing ? 'Edit Subscription' : 'Details',
        style: TextStyle(
          color: SubscriptionDetailsPageState.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),

      // No edit icon in the AppBar.
      actions: const [],
    );
  }
}
