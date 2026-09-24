import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFFF8500).withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFFF8500).withValues(alpha: 0.22),
                ),
              ),
              child: const Icon(
                Icons.add_card_rounded,
                color: Color(0xFFFF8500),
                size: 29,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create your subscription',
                    style: TextStyle(
                      color: Color(0xFFF5F7FA),
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Keep track of your recurring payments.',
                    style: TextStyle(
                      color: Color(0xFF929DA8),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
