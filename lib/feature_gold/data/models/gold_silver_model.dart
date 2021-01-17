import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_gold/data/models/gold_silver_category.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';

class GoldSilverModel extends GoldSilverEntity {
  GoldSilverModel({
    @required String id,
    @required double price,
    @required DateTime publishedAt,
    @required String unit,
    @required GoldSilverCategoryModel category,
    @required DateTime createdAt,
    @required DateTime updatedAt,
    @required bool isLiked,
    @required bool isCommented,
    @required bool isShared,
    @required bool isViewed,
    @required int commentCount,
    @required int likeCount,
    @required int shareCount,
    @required int viewCount,
  }) : super(
            id: id,
            price: price,
            publishedAt: publishedAt,
            unit: unit,
            category: category,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isLiked: isLiked,
            isCommented: isCommented,
            isShared: isShared,
            isViewed: isViewed,
            commentCount: commentCount,
            likeCount: likeCount,
            shareCount: shareCount,
            viewCount: viewCount);

  factory GoldSilverModel.fromJson(String str) =>
      GoldSilverModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoldSilverModel.fromMap(Map<String, dynamic> json) => GoldSilverModel(
        id: json["id"].toString(),
        price: json["price"].toDouble(),
        publishedAt: DateTime.parse(json["publishedAt"]),
        unit: json["unit"],
        category: GoldSilverCategoryModel.fromMap(json["category"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isLiked: json["is_liked"],
        isCommented: json["is_commented"],
        isShared: json["is_shared"],
        isViewed: json["is_viewed"],
        commentCount: json["comment_count"],
        likeCount: json["like_count"],
        shareCount: json["share_count"],
        viewCount: json["view_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "publishedAt":
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
