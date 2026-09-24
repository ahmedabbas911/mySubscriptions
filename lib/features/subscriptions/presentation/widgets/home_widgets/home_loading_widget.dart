import 'package:flutter/material.dart';

class HomeLoadingWidget extends StatelessWidget {
  final Color orangeColor;

  const HomeLoadingWidget({super.key, required this.orangeColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: orangeColor, strokeWidth: 2.5),
    );
  }
}
