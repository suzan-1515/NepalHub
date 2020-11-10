import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:validators/validators.dart' as Validator;

class NewsCategoryEntity extends Equatable {
  final String id;
  final String title;
  final String code;
  final String icon;
  final int priority;
  final bool isFollowed;
  final int followerCount;
  final bool isBlocked;
  final Language language;
  final DateTime updatedAt;
  final DateTime createdAt;

  NewsCategoryEntity({
    @required this.id,
    @required this.title,
    @required this.code,
    this.icon,
    @required this.priority,
    @required this.isFollowed,
    @required this.followerCount,
    @required this.isBlocked,
    @required this.language,
    @required this.updatedAt,
    @required this.createdAt,
  });

  bool get isValidIcon => Validator.isURL(icon);

  NewsCategoryEntity copyWith({
    String id,
    String title,
    String code,
    String icon,
    int priority,
    bool isFollowed,
    int followerCount,
    bool isBlocked,
    Language language,
    DateTime updatedAt,
    DateTime createdAt,
  }) =>
      NewsCategoryEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        code: code ?? this.code,
        icon: icon ?? this.icon,
        priority: priority ?? this.priority,
        isFollowed: isFollowed ?? this.isFollowed,
        followerCount: followerCount ?? this.followerCount,
        isBlocked: isBlocked ?? this.isBlocked,
        language: language ?? this.language,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => [
        id,
        title,
        code,
        icon,
        priority,
        isFollowed,
        followerCount,
        isBlocked,
        language
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "code": code,
        "priority": priority,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": {"url": icon},
        "is_followed": isFollowed,
        "follower_count": followerCount,
        "is_blocked": isBlocked,
      };

  @override
  bool get stringify => true;
}
