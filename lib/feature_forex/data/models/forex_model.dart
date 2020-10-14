import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_forex/data/models/currency_model.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';

class ForexModel extends ForexEntity {
  ForexModel({
    @required String id,
    @required int unit,
    @required double buying,
    @required double selling,
    @required String source,
    @required String sourceUrl,
    @required DateTime publishedAt,
    @required ForexCurrencyModel currency,
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
          unit: unit,
          buying: buying,
          selling: selling,
          source: source,
          sourceUrl: sourceUrl,
          publishedAt: publishedAt,
          currency: currency,
          createdAt: createdAt,
          updatedAt: updatedAt,
          isLiked: isLiked,
          isCommented: isCommented,
          isShared: isShared,
          isViewed: isViewed,
          commentCount: commentCount,
          likeCount: likeCount,
          shareCount: shareCount,
          viewCount: viewCount,
        );

  factory ForexModel.fromJson(String str) =>
      ForexModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForexModel.fromMap(Map<String, dynamic> json) => ForexModel(
        id: json["id"].toString(),
        unit: json["unit"],
        buying: json["buying"].toDouble(),
        selling: json["selling"].toDouble(),
        source: json["source"],
        sourceUrl: json["source_url"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        currency: ForexCurrencyModel.fromMap(json["currency"]),
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
        "unit": unit,
        "buying": buying,
        "selling": selling,
        "source": source,
        "source_url": sourceUrl,
        "publishedAt": publishedAt.toIso8601String(),
        "currency": (currency as ForexCurrencyModel).toMap(),
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
