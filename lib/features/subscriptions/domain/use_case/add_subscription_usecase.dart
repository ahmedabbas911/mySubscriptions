import 'package:injectable/injectable.dart';

import '../entity/subscription_entity.dart';
import '../repo/subscription_repo.dart';

@injectable
class AddSubscriptionUseCase {
  final SubscriptionRepo repository;

  AddSubscriptionUseCase(this.repository);

  Future<void> call(SubscriptionEntity subscription) async {
    return repository.addSubscription(subscription);
  }
}
