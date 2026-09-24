import '../../domain/entity/subscription_entity.dart';

abstract class SubscriptionState {}

class SubscriptionInitialState extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState {}

class SubscriptionSuccessState extends SubscriptionState {
  final List<SubscriptionEntity> subscriptions;

  SubscriptionSuccessState({required this.subscriptions});
}

class SubscriptionEmptyState extends SubscriptionState {}

class SubscriptionErrorState extends SubscriptionState {
  final String errorMessage;

  SubscriptionErrorState({required this.errorMessage});
}
