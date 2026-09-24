import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/subscription_entity.dart';
import '../../domain/use_case/add_subscription_usecase.dart';
import '../../domain/use_case/delete_subscription_usecase.dart';
import '../../domain/use_case/get_subscriptions_usecase.dart';
import '../../domain/use_case/update_subscription_usecase.dart';
import 'subscription_state.dart';

@injectable
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionsUseCase getSubscriptionsUseCase;
  final AddSubscriptionUseCase addSubscriptionUseCase;
  final UpdateSubscriptionUseCase updateSubscriptionUseCase;
  final DeleteSubscriptionUseCase deleteSubscriptionUseCase;

  SubscriptionCubit(
    this.getSubscriptionsUseCase,
    this.addSubscriptionUseCase,
    this.updateSubscriptionUseCase,
    this.deleteSubscriptionUseCase,
  ) : super(SubscriptionInitialState());

  Future<void> loadSubscriptions() async {
    emit(SubscriptionLoadingState());
    try {
      final subscriptions = await getSubscriptionsUseCase.call();
      if (subscriptions.isEmpty) {
        emit(SubscriptionEmptyState());
      } else {
        emit(SubscriptionSuccessState(subscriptions: subscriptions));
      }
    } catch (e) {
      emit(SubscriptionErrorState(errorMessage: 'Failed to load subscriptions'));
    }
  }

  Future<void> addSubscription(SubscriptionEntity subscription) async {
    emit(SubscriptionLoadingState());
    try {
      await addSubscriptionUseCase.call(subscription);
      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionErrorState(errorMessage: 'Failed to add subscription'));
    }
  }

  Future<void> updateSubscription(SubscriptionEntity subscription) async {
    emit(SubscriptionLoadingState());
    try {
      await updateSubscriptionUseCase.call(subscription);
      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionErrorState(errorMessage: 'Failed to update subscription'));
    }
  }

  Future<void> deleteSubscription(String id) async {
    emit(SubscriptionLoadingState());
    try {
      await deleteSubscriptionUseCase.call(id);
      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionErrorState(errorMessage: 'Failed to delete subscription'));
    }
  }
}
