import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/get_current_user_usecase.dart';
import '../../domain/use_case/login_usecase.dart';
import '../../domain/use_case/logout_usecase.dart';
import '../../domain/use_case/register_usecase.dart';
import '../../domain/use_case/send_password_reset_email_usecase.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit(
    this.loginUseCase,
    this.registerUseCase,
    this.logoutUseCase,
    this.sendPasswordResetEmailUseCase,
    this.getCurrentUserUseCase,
  ) : super(AuthInitialState());

  Future<void> checkAuthStatus() async {
    emit(AuthLoadingState());
    try {
      final user = await getCurrentUserUseCase.call();
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthInitialState());
      }
    } catch (_) {
      emit(AuthInitialState());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final user = await loginUseCase.call(email: email, password: password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(errorMessage: 'Failed to login'));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final user =
          await registerUseCase.call(email: email, password: password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthError(errorMessage: 'Failed to register'));
    }
  }

  Future<void> logout() async {
    await logoutUseCase.call();
    emit(AuthInitialState());
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await sendPasswordResetEmailUseCase.call(email);
    } catch (e) {
      rethrow;
    }
  }
}
