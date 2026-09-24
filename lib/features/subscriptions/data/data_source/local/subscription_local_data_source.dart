import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

import '../../models/subscription_model.dart';

@injectable
class SubscriptionLocalDataSource {
  final Box<SubscriptionModel> subscriptionBox;

  SubscriptionLocalDataSource(this.subscriptionBox);

  Future<void> addSubscription(SubscriptionModel subscription) async {
    await subscriptionBox.put(subscription.id, subscription);
  }

  Future<List<SubscriptionModel>> getSubscriptions() async {
    return subscriptionBox.values.toList();
  }

  Future<void> deleteSubscription(String id) async {
    await subscriptionBox.delete(id);
  }

  Future<void> updateSubscription(SubscriptionModel subscription) async {
    await subscriptionBox.put(subscription.id, subscription);
  }
}
