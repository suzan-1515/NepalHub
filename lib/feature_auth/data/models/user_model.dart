import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    @required String id,
    @required String email,
    @required String username,
    @required String fullname,
    @required String token,
    @required String avatar,
    @required bool isAnonymous,
    @required bool isBlocked,
    @required bool isNewUser,
    @required String method,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  }) : super(
          id: id,
          email: email,
          username: username,
          fullname: fullname,
          token: token,
          avatar: avatar,
          isAnonymous: isAnonymous,
          isBlocked: isBlocked,
          isNewUser: isNewUser,
          method: method,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"].toString(),
        email: json["email"],
        username: json["username"],
        fullname: json["displayname"],
        token: json["jwt"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        avatar: json["avatar"],
        isAnonymous: json["is_anonymous"],
        isBlocked: json["is_blocked"],
        isNewUser: json["is_new_user"],
        method: json["provider"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "username": username,
        "displayname": fullname,
        "jwt": token,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "avatar": avatar,
        "is_anonymous": isAnonymous,
        "is_blocked": isBlocked,
        "is_new_user": isNewUser,
        "provider": method,
      };
}
