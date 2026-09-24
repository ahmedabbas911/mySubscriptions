import 'package:hive_ce/hive.dart';

import '../../domain/entity/subscription_entity.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 0)
class SubscriptionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String billingCycle;

  @HiveField(4)
  final DateTime nextRenewalDate;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final String? notes;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final String userId;

  const SubscriptionModel({
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

  factory SubscriptionModel.fromEntity(SubscriptionEntity entity) {
    return SubscriptionModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      billingCycle: entity.billingCycle.name,
      nextRenewalDate: entity.nextRenewalDate,
      category: entity.category,
      notes: entity.notes,
      status: entity.status.name,
      userId: entity.userId,
    );
  }

  SubscriptionEntity toEntity() {
    return SubscriptionEntity(
      id: id,
      name: name,
      price: price,
      billingCycle: BillingCycle.values.byName(billingCycle),
      nextRenewalDate: nextRenewalDate,
      category: category,
      notes: notes,
      status: SubscriptionStatus.values.byName(status),
      userId: userId,
    );
  }
}
