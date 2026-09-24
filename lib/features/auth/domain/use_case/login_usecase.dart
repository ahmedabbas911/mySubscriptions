import 'package:injectable/injectable.dart';
import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';
import 'package:my_subscriptions/features/auth/domain/repo/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return authRepo.login(email: email, password: password);
  }
}
