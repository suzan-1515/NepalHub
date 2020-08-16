import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uId;
  final String fullName;
  final String email;
  final String avatar;
  final bool isAnonymous;

  UserModel(
      {this.uId,
      this.fullName,
      this.email,
      this.avatar,
      this.isAnonymous = false});

  factory UserModel.fromFirebaseUser(FirebaseUser user) => UserModel(
      uId: user.uid,
      fullName: user.displayName,
      email: user.email,
      avatar: user.photoUrl,
      isAnonymous: user.isAnonymous);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uId: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      avatar: json['avatar']);

  Map<String, dynamic> toJson() => {
        'id': this.uId,
        'full_name': this.fullName,
        'email': this.email,
        'avatar': this.avatar,
      };
}
