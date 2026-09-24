import 'package:injectable/injectable.dart';
import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';
import 'package:my_subscriptions/features/auth/domain/repo/auth_repo.dart';

@injectable
class RegisterUseCase {
  AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return authRepo.register(email: email, password: password);
  }
}
