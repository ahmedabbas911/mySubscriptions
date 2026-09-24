import 'package:injectable/injectable.dart';

import '../entity/subscription_entity.dart';
import '../repo/subscription_repo.dart';

@injectable
class UpdateSubscriptionUseCase {
  final SubscriptionRepo repository;

  UpdateSubscriptionUseCase(this.repository);

  Future<void> call(SubscriptionEntity subscription) async {
    return repository.updateSubscription(subscription);
  }
}
