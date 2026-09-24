import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final String formattedDate;
  final VoidCallback onTap;

  const DateSelector({required this.formattedDate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF10161C),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFF29333D)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFF8500).withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: Color(0xFFFF8500),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Renewal date',
                    style: TextStyle(color: Color(0xFF929DA8), fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      color: Color(0xFFF5F7FA),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF929DA8),
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}
