import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_type.dart';
import 'package:validators/validators.dart' as Validator;

class NewsFeedEntity extends Equatable {
  final String id;
  final NewsSourceEntity source;
  final NewsCategoryEntity category;
  final List<NewsTopicEntity> topics;
  final String author;
  final String title;
  final String description;
  final String link;
  final String image;
  final DateTime publishedDate;
  final String content;
  final String uuid;
  final String parent;
  final bool isBookmarked;
  final bool isCommented;
  final bool isViewed;
  final bool isShared;
  final bool isLiked;
  final int likeCount;
  final int bookmarkCount;
  final int shareCount;
  final int commentCount;
  final int viewCount;
  final int page;
  final NewsType type;
  final Language language;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NewsFeedEntity({
    @required this.id,
    @required this.source,
    @required this.category,
    @required this.topics,
    this.author,
    @required this.title,
    this.description,
    @required this.link,
    this.image,
    @required this.publishedDate,
    this.content,
    @required this.uuid,
    this.parent,
    @required this.isBookmarked,
    @required this.isLiked,
    @required this.isShared,
    @required this.isCommented,
    @required this.isViewed,
    @required this.likeCount,
    @required this.bookmarkCount,
    @required this.shareCount,
    @required this.commentCount,
    @required this.viewCount,
    @required this.language,
    @required this.type,
    this.page,
    @required this.createdAt,
    @required this.updatedAt,
  });

  bool get isValidLink => Validator.isURL(link);

  bool get isValidImage => Validator.isURL(image);

  NewsFeedEntity copyWith({
    String id,
    NewsSourceEntity source,
    NewsCategoryEntity category,
    List<NewsTopicEntity> topics,
    String author,
    String title,
    String description,
    String link,
    String image,
    DateTime publishedDate,
    String content,
    String uuid,
    String parent,
    bool isBookmarked,
    bool isCommented,
    bool isShared,
    bool isViewed,
    bool isLiked,
    int likeCount,
    int bookmarkCount,
    int shareCount,
    int commentCount,
    int viewCount,
    int page,
    NewsType type,
    Language language,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      NewsFeedEntity(
        id: id ?? this.id,
        source: source ?? this.source,
        category: category ?? this.category,
        topics: topics ?? this.topics,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        content: content ?? this.content,
        link: link ?? this.link,
        image: image ?? this.image,
        publishedDate: publishedDate ?? this.publishedDate,
        uuid: uuid ?? this.uuid,
        parent: parent ?? this.parent,
        isBookmarked: isBookmarked ?? this.isBookmarked,
        isCommented: isCommented ?? this.isCommented,
        isShared: isShared ?? this.isShared,
        isViewed: isViewed ?? this.isViewed,
        isLiked: isLiked ?? this.isLiked,
        likeCount: likeCount ?? this.likeCount,
        bookmarkCount: bookmarkCount ?? this.bookmarkCount,
        shareCount: shareCount ?? this.shareCount,
        viewCount: viewCount ?? this.viewCount,
        commentCount: commentCount ?? this.commentCount,
        language: language ?? this.language,
        page: page ?? this.page,
        type: type ?? this.type,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        source,
        category,
        topics,
        author,
        title,
        description,
        link,
        image,
        publishedDate,
        content,
        uuid,
        parent,
        isBookmarked,
        isLiked,
        isShared,
        isCommented,
        isViewed,
        likeCount,
        bookmarkCount,
        shareCount,
        commentCount,
        viewCount,
        language,
        page,
        type
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "content": content,
        "link": link,
        "publishedAt": publishedDate.toIso8601String(),
        "author": author,
        "uuid": uuid,
        "category": category.toMap(),
        "source": source.toMap(),
        "language": language.value,
        "image": image,
        "type": type.value,
        "parent_id": parent,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "topics": topics?.map((x) => x.toMap())?.toList(),
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
