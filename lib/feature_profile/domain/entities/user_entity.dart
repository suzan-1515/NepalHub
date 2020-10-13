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
      method: method ?? this.method,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;
}
