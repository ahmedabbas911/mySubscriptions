import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccess extends AuthState {
  UserEntity user;

  AuthSuccess({required this.user});
}

class AuthError extends AuthState {
  String? errorMessage;

  AuthError({required this.errorMessage});
}
