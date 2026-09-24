import 'package:flutter/material.dart';

import '../../../domain/entity/subscription_entity.dart';
import 'add_subscription_cycle_option_widget.dart';

class BillingCycleSelector extends StatelessWidget {
  final BillingCycle selectedCycle;
  final ValueChanged<BillingCycle> onChanged;

  const BillingCycleSelector({
    required this.selectedCycle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF10161C),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF29333D)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CycleOption(
              title: 'Monthly',
              icon: Icons.calendar_month_outlined,
              isSelected: selectedCycle == BillingCycle.monthly,
              onTap: () {
                onChanged(BillingCycle.monthly);
              },
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: CycleOption(
              title: 'Yearly',
              icon: Icons.calendar_today_outlined,
              isSelected: selectedCycle == BillingCycle.yearly,
              onTap: () {
                onChanged(BillingCycle.yearly);
              },
            ),
          ),
        ],
      ),
    );
  }
}
