import 'package:injectable/injectable.dart';

import '../entity/subscription_entity.dart';
import '../repo/subscription_repo.dart';

@injectable
class GetSubscriptionsUseCase {
  final SubscriptionRepo repository;

  GetSubscriptionsUseCase(this.repository);

  Future<List<SubscriptionEntity>> call() async {
    return repository.getSubscriptions();
  }
}
