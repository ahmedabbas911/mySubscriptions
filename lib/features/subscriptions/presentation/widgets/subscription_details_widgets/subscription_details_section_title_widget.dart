import 'package:flutter/cupertino.dart';

import '../../pages/subscription_details_page.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: SubscriptionDetailsPageState.primaryText,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
