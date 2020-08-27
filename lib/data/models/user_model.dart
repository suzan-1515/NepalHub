import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uId;
  final String fullName;
  final String email;
  final String avatar;
  final bool isAnonymous;
  final String provider;
  final String phoneNumber;
  final DateTime createdAt;

  UserModel(
      {this.uId,
      this.fullName,
      this.email,
      this.avatar,
      this.isAnonymous = false,
      this.provider,
      this.phoneNumber,
      this.createdAt});

  String get firstName => fullName?.split(' ')[0];

  factory UserModel.fromFirebaseUser(UserCredential user) => UserModel(
      uId: user.user.uid,
      fullName: user.user.displayName,
      email: user.user.email,
      avatar: user.user.photoURL,
      isAnonymous: user.user.isAnonymous,
      phoneNumber: user.user.phoneNumber,
      provider: user.additionalUserInfo.providerId,
      createdAt: user.user.metadata.creationTime);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uId: json['id'],
        fullName: json['full_name'],
        email: json['email'],
        avatar: json['avatar'],
        isAnonymous: json['is_anonymous'],
        provider: json['provider'],
        phoneNumber: json['phone_number'],
        createdAt: (json['created_date'] == null)
            ? null
            : DateTime.parse(json['created_date']),
      );

  Map<String, dynamic> toJson() => {
        'id': this.uId,
        'full_name': this.fullName,
        'email': this.email,
        'avatar': this.avatar,
        'is_anonymous': this.isAnonymous,
        'provider': this.provider,
        'phone_number': this.phoneNumber,
        'created_date': this.createdAt.toIso8601String()
      };
}
