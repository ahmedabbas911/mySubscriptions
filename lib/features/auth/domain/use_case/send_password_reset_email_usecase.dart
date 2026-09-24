import 'package:injectable/injectable.dart';
import 'package:my_subscriptions/features/auth/domain/repo/auth_repo.dart';

@injectable
class SendPasswordResetEmailUseCase {
  final AuthRepo authRepo;

  SendPasswordResetEmailUseCase(this.authRepo);

  Future<void> call(String email) async {
    return authRepo.sendPasswordResetEmail(email);
  }
}
