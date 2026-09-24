import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_subscriptions/features/auth/domain/entity/user_entity.dart';

class AuthModel {
  String? email;
  String? uid;

  AuthModel({this.email, this.uid});

  factory AuthModel.fromFirebaseUser(User user) {
    return AuthModel(email: user.email, uid: user.uid);
  }

  UserEntity toEntity() {
    return UserEntity(email: email!, uid: uid!);
  }
}
