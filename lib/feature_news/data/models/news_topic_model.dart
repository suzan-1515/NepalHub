import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';

class NewsTopicModel extends NewsTopicEntity {
  NewsTopicModel({
    @required String id,
    @required String title,
    @required String icon,
    @required bool isFollowed,
    @required int followerCount,
    @required bool isBlocked,
    @required List<NewsCategoryModel> categories,
    @required Language language,
    @required DateTime updatedAt,
    @required DateTime createdAt,
  }) : super(
            id: id,
            title: title,
            icon: icon,
            categories: categories,
            isFollowed: isFollowed,
            followerCount: followerCount,
            isBlocked: isBlocked,
            language: language,
            updatedAt: updatedAt,
            createdAt: createdAt);

  factory NewsTopicModel.fromJson(String str) =>
      NewsTopicModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsTopicModel.fromMap(Map<String, dynamic> json) => NewsTopicModel(
        id: json["id"].toString(),
        title: json["title"],
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: json["icon"],
        categories: json['categories'] == null
            ? null
            : List<NewsCategoryModel>.from(
                json['categories'].map((e) => NewsCategoryModel.fromMap(e))),
        isFollowed: json["is_followed"],
        followerCount: json["follower_count"],
        isBlocked: json["is_blocked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "language": language.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": icon,
        "categories":
            categories?.map((e) => (e as NewsCategoryModel).toMap())?.toList(),
        "is_followed": isFollowed,
        "follower_count": followerCount,
        "is_blocked": isBlocked,
      };
}
