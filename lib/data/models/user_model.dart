import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  final String uId;
  final String fullName;
  final String email;
  final String avatar;

  UserModel({this.uId, this.fullName, this.email, this.avatar});

  factory UserModel.fromFirebaseUser(FirebaseUser user) => UserModel(
      uId: user.uid,
      fullName: user.displayName,
      email: user.email,
      avatar: user.photoUrl);

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
