import 'package:injectable/injectable.dart';
import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';
import 'package:my_subscriptions/features/auth/domain/repo/auth_repo.dart';

@injectable
class GetCurrentUserUseCase {
  AuthRepo authRepo;

  GetCurrentUserUseCase(this.authRepo);

  Future<UserEntity?> call() async {
    return authRepo.getCurrentUser();
  }
}
