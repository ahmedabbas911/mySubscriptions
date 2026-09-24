import 'package:flutter/cupertino.dart';

class BackgroundGlow extends StatelessWidget {
  const BackgroundGlow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          boxShadow: [
            BoxShadow(color: color, blurRadius: 140, spreadRadius: 45),
          ],
        ),
      ),
    );
  }
}
