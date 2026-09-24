import 'package:injectable/injectable.dart';

import '../../../auth/domain/repo/auth_repo.dart';
import '../../domain/entity/subscription_entity.dart';
import '../../domain/repo/subscription_repo.dart';
import '../data_source/local/subscription_local_data_source.dart';
import '../models/subscription_model.dart';

@Injectable(as: SubscriptionRepo)
class SubscriptionRepoImpl implements SubscriptionRepo {
  final SubscriptionLocalDataSource localDataSource;
  final AuthRepo authRepo;

  SubscriptionRepoImpl(this.localDataSource, this.authRepo);

  @override
  Future<void> addSubscription(SubscriptionEntity subscription) async {
    final currentUser = await authRepo.getCurrentUser();
    if (currentUser == null) {
      throw Exception('User is not logged in. Cannot save subscription.');
    }

    final userId = currentUser.uid;
    final id = subscription.id.isNotEmpty
        ? subscription.id
        : DateTime.now().millisecondsSinceEpoch.toString();

    final finalEntity = SubscriptionEntity(
      id: id,
      name: subscription.name,
      price: subscription.price,
      billingCycle: subscription.billingCycle,
      nextRenewalDate: subscription.nextRenewalDate,
      category: subscription.category,
      notes: subscription.notes,
      status: subscription.status,
      userId: userId,
    );

    final model = SubscriptionModel.fromEntity(finalEntity);
    await localDataSource.addSubscription(model);
  }

  @override
  Future<List<SubscriptionEntity>> getSubscriptions() async {
    final models = await localDataSource.getSubscriptions();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> deleteSubscription(String id) async {
    await localDataSource.deleteSubscription(id);
  }

  @override
  Future<void> updateSubscription(SubscriptionEntity subscription) async {
    final model = SubscriptionModel.fromEntity(subscription);
    await localDataSource.updateSubscription(model);
  }
}
