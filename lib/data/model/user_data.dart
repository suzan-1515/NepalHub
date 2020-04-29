import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uId;
  final String fullName;
  final String email;
  final String avatar;

  User({this.uId, this.fullName, this.email, this.avatar});

  factory User.fromFirebaseUser(FirebaseUser user) => User(
      uId: user.uid,
      fullName: user.displayName,
      email: user.email,
      avatar: user.photoUrl);

  factory User.fromJson(Map<String, dynamic> data) => User(
      uId: data['id'],
      fullName: data['full_name'],
      email: data['email'],
      avatar: data['avatar']);

  Map<String, dynamic> toJson() {
    return {
      'id': uId,
      'full_name': fullName,
      'email': email,
      'avatar': avatar,
    };
  }
}
