import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/subscription_model.dart';

@module
abstract class SubscriptionsModule {
  @preResolve
  Future<Box<SubscriptionModel>> get subscriptionBox async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SubscriptionModelAdapter());
    }

    return Hive.openBox<SubscriptionModel>('subscriptions');
  }
}
