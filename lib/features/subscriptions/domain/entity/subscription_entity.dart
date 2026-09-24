enum BillingCycle { monthly, yearly }

enum SubscriptionStatus { active, cancelled }

class SubscriptionEntity {
  final String id;
  final String name;
  final double price;
  final BillingCycle billingCycle;
  final DateTime nextRenewalDate;
  final String category;
  final String? notes;
  final SubscriptionStatus status;
  final String userId;

  const SubscriptionEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.billingCycle,
    required this.nextRenewalDate,
    required this.category,
    this.notes,
    required this.status,
    required this.userId,
  });
}
