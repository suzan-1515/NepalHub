import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_category_entity.dart';

class GoldSilverEntity {
  GoldSilverEntity({
    @required this.id,
    @required this.price,
    @required this.publishedAt,
    @required this.unit,
    @required this.category,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.isLiked,
    @required this.isCommented,
    @required this.isShared,
    @required this.isViewed,
    @required this.commentCount,
    @required this.likeCount,
    @required this.shareCount,
    @required this.viewCount,
  });

  final String id;
  final double price;
  final DateTime publishedAt;
  final String unit;
  final GoldSilverCategoryEntity category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isLiked;
  final bool isCommented;
  final bool isShared;
  final bool isViewed;
  final int commentCount;
  final int likeCount;
  final int shareCount;
  final int viewCount;

  GoldSilverEntity copyWith({
    String id,
    double price,
    DateTime publishedAt,
    String unit,
    GoldSilverCategoryEntity category,
    DateTime createdAt,
    DateTime updatedAt,
    bool isLiked,
    bool isCommented,
    bool isShared,
    bool isViewed,
    int commentCount,
    int likeCount,
    int shareCount,
    int viewCount,
  }) =>
      GoldSilverEntity(
        id: id ?? this.id,
        price: price ?? this.price,
        publishedAt: publishedAt ?? this.publishedAt,
        unit: unit ?? this.unit,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isLiked: isLiked ?? this.isLiked,
        isCommented: isCommented ?? this.isCommented,
        isShared: isShared ?? this.isShared,
        isViewed: isViewed ?? this.isViewed,
        commentCount: commentCount ?? this.commentCount,
        likeCount: likeCount ?? this.likeCount,
        shareCount: shareCount ?? this.shareCount,
        viewCount: viewCount ?? this.viewCount,
      );

  String get formatttedDate => DateFormat('dd MMMM, yyyy').format(publishedAt);

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "published_at":
            "${publishedAt.year.toString().padLeft(4, '0')}-${publishedAt.month.toString().padLeft(2, '0')}-${publishedAt.day.toString().padLeft(2, '0')}",
        "unit": unit,
        "category": category.toMap(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_liked": isLiked,
        "is_commented": isCommented,
        "is_shared": isShared,
        "is_viewed": isViewed,
        "comment_count": commentCount,
        "like_count": likeCount,
        "share_count": shareCount,
        "view_count": viewCount,
      };
}
