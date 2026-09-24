import 'package:injectable/injectable.dart';

import '../repo/subscription_repo.dart';

@injectable
class DeleteSubscriptionUseCase {
  final SubscriptionRepo repository;

  DeleteSubscriptionUseCase(this.repository);

  Future<void> call(String id) async {
    return repository.deleteSubscription(id);
  }
}
