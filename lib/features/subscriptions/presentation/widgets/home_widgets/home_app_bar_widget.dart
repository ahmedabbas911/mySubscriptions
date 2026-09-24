import 'package:flutter/material.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color primaryTextColor;
  final Color surfaceColor;
  final VoidCallback onLogoutPressed;

  const HomeAppBarWidget({
    super.key,
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.surfaceColor,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 108,
      titleSpacing: 24,

      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good morning 👋',
            style: TextStyle(
              color: Color(0xFF8D98A5),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            'Manage your subscriptions',
            style: TextStyle(
              color: primaryTextColor,
              fontSize: 19,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 3),

          const Text(
            'Keep track of your recurring payments',
            style: TextStyle(
              color: Color(0xFF68737F),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: onLogoutPressed,
            style: IconButton.styleFrom(
              backgroundColor: surfaceColor,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
              shape: const CircleBorder(),
            ),
            icon: Icon(Icons.logout_rounded, color: primaryTextColor, size: 19),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(108);
}
