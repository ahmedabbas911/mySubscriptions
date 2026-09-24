import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_subscriptions/features/auth/data/models/auth_model.dart';

@injectable
class AuthRemoteDataSource {
  FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  Future<AuthModel> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthModel.fromFirebaseUser(credential.user!);
  }

  Future<AuthModel> register(String email, String password) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthModel.fromFirebaseUser(credential.user!);
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
