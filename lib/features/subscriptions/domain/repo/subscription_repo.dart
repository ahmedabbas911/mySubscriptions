import '../entity/subscription_entity.dart';

abstract class SubscriptionRepo {
  Future<void> addSubscription(SubscriptionEntity subscription);

  Future<List<SubscriptionEntity>> getSubscriptions();

  Future<void> deleteSubscription(String id);

  Future<void> updateSubscription(SubscriptionEntity subscription);
}
