import 'package:injectable/injectable.dart';
import 'package:my_subscriptions/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:my_subscriptions/features/auth/data/models/auth_model.dart';
import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';
import 'package:my_subscriptions/features/auth/domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await authRemoteDataSource.login(email, password);
    return credential.toEntity();
  }

  @override
  Future<void> logout() {
    return authRemoteDataSource.logout();
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
  }) async {
    final credential = await authRemoteDataSource.register(email, password);
    return credential.toEntity();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await authRemoteDataSource.getCurrentUser();
    if (user == null) {
      return null;
    }
    return AuthModel.fromFirebaseUser(user).toEntity();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await authRemoteDataSource.sendPasswordResetEmail(email);
  }
}
