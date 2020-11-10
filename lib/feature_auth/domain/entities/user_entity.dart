import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String username;
  final String fullname;
  final String token;
  final String avatar;
  final bool isAnonymous;
  final bool blocked;
  final bool confirmed;
  final bool isNew;
  final String method;
  final DateTime createdAt;
  final DateTime updatedAt;
  UserEntity({
    @required this.id,
    @required this.email,
    @required this.username,
    @required this.fullname,
    @required this.token,
    @required this.avatar,
    @required this.isAnonymous,
    @required this.blocked,
    @required this.confirmed,
    @required this.isNew,
    @required this.method,
    @required this.createdAt,
    @required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      email,
      username,
      fullname,
      token,
      avatar,
      isAnonymous,
      blocked,
      confirmed,
      isNew,
      method,
      createdAt,
      updatedAt,
    ];
  }

  UserEntity copyWith({
    String id,
    String email,
    String username,
    String fullname,
    String token,
    String avatar,
    bool isAnonymous,
    bool blocked,
    bool confirmed,
    bool isNew,
    String method,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      token: token ?? this.token,
      avatar: avatar ?? this.avatar,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      blocked: blocked ?? this.blocked,
      confirmed: confirmed ?? this.confirmed,
      isNew: isNew ?? this.isNew,
      method: method ?? this.method,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "username": username,
        "fullname": fullname,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "avatar": avatar,
        "is_anonymous": isAnonymous,
        "blocked": blocked,
        "confirmed": confirmed,
        "is_new": isNew,
        "provider": method,
        "jwt": token,
      };

  @override
  bool get stringify => true;
}
