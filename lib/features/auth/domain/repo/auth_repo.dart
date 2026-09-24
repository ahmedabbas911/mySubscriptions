import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<UserEntity> login({required String email, required String password});

  Future<UserEntity> register({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();

  Future<void> sendPasswordResetEmail(String email);
}
