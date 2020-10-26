import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/data/models/news_category_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_source_model.dart';
import 'package:samachar_hub/feature_news/data/models/news_topic_model.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_type.dart';

class NewsFeedModel extends NewsFeedEntity {
  NewsFeedModel({
    @required String id,
    @required NewsSourceModel source,
    @required NewsCategoryModel category,
    @required List<NewsTopicModel> topics,
    @required String author,
    @required String title,
    @required String description,
    @required String link,
    @required String image,
    @required DateTime publishedDate,
    @required String content,
    @required String uuid,
    @required String parent,
    @required bool isBookmarked,
    @required bool isCommented,
    @required bool isViewed,
    @required bool isShared,
    @required bool isLiked,
    @required int likeCount,
    @required int bookmarkCount,
    @required int shareCount,
    @required int commentCount,
    @required int viewCount,
    @required NewsType type,
    @required Language language,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  }) : super(
            id: id,
            category: category,
            source: source,
            topics: topics,
            author: author,
            title: title,
            description: description,
            content: content,
            publishedDate: publishedDate,
            link: link,
            image: image,
            uuid: uuid,
            parent: parent,
            isBookmarked: isBookmarked,
            isCommented: isCommented,
            isShared: isShared,
            isViewed: isViewed,
            isLiked: isLiked,
            likeCount: likeCount,
            bookmarkCount: bookmarkCount,
            shareCount: shareCount,
            commentCount: commentCount,
            viewCount: viewCount,
            type: type,
            language: language,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory NewsFeedModel.fromJson(String str) =>
      NewsFeedModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsFeedModel.fromMap(Map<String, dynamic> json) => NewsFeedModel(
        id: json["id"].toString(),
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        content: json["content"] == null ? null : json["content"],
        link: json["link"],
        publishedDate: DateTime.parse(json["publishedAt"]),
        author: json["author"] == null ? null : json["author"],
        uuid: json["uuid"],
        category: NewsCategoryModel.fromMap(json["category"]),
        source: NewsSourceModel.fromMap(json["source"]),
        language: (json["language"] as String).toLanguage,
        image: json["image"],
        type: (json["type"] as String).toNewsType,
        parent: json["parent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        topics: json["topics"] == null
            ? null
            : List<NewsTopicModel>.from(
                json["topics"].map((x) => NewsTopicModel.fromMap(x))),
        isLiked: json["is_liked"],
        isCommented: json["is_commented"],
        isShared: json["is_shared"],
        isViewed: json["is_viewed"],
        isBookmarked: json["is_bookmarked"],
        commentCount: json["comment_count"],
        likeCount: json["like_count"],
        shareCount: json["share_count"],
        viewCount: json["view_count"],
        bookmarkCount: json["bookmark_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description == null ? null : description,
        "content": content,
        "link": link,
        "publishedAt": publishedDate.toIso8601String(),
        "author": author,
        "uuid": uuid,
        "category": (category as NewsCategoryModel).toMap(),
        "source": (source as NewsSourceModel).toMap(),
        "language": language,
        "image": image,
        "type": type.value,
        "parent_id": parent,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "topics": topics?.map((x) => (x as NewsTopicModel).toMap())?.toList(),
        "is_liked": isLiked,
        "is_commented": isCommented,
        "is_shared": isShared,
        "is_viewed": isViewed,
        "is_bookmarked": isBookmarked,
        "comment_count": commentCount,
        "like_count": likeCount,
        "share_count": shareCount,
        "view_count": viewCount,
        "bookmark_count": bookmarkCount,
      };
}
