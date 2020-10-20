import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';

class NewsSourceModel extends NewsSourceEntity {
  NewsSourceModel({
    @required String id,
    @required String title,
    @required String code,
    @required String icon,
    @required String favicon,
    @required int priority,
    @required bool isFollowed,
    @required int followerCount,
    @required bool isBlocked,
    @required Language language,
    @required DateTime updatedAt,
    @required DateTime createdAt,
  }) : super(
            id: id,
            title: title,
            code: code,
            icon: icon,
            favicon: favicon,
            priority: priority,
            isFollowed: isFollowed,
            followerCount: followerCount,
            isBlocked: isBlocked,
            language: language,
            updatedAt: updatedAt,
            createdAt: createdAt);

  factory NewsSourceModel.fromJson(String str) =>
      NewsSourceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsSourceModel.fromMap(Map<String, dynamic> json) => NewsSourceModel(
        id: json["id"].toString(),
        title: json["title"],
        code: json["code"],
        priority: json["priority"],
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: (json["icon"] != null) ? json["icon"]["url"] : null,
        favicon: (json["favicon"] != null) ? json["favicon"]["url"] : null,
        isFollowed: json["is_followed"],
        followerCount: json["follower_count"],
        isBlocked: json["is_blocked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "code": code,
        "priority": priority,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": {"url": icon},
        "favicon": {"url": favicon},
        "is_followed": isFollowed,
        "follower_count": followerCount,
        "is_blocked": isBlocked,
      };
}
