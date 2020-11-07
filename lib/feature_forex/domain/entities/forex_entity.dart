import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:samachar_hub/feature_forex/domain/entities/currency_entity.dart';

class ForexEntity extends Equatable {
  ForexEntity({
    @required this.id,
    @required this.unit,
    @required this.buying,
    @required this.selling,
    @required this.source,
    @required this.sourceUrl,
    @required this.publishedAt,
    @required this.currency,
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
  final int unit;
  final double buying;
  final double selling;
  final String source;
  final String sourceUrl;
  final DateTime publishedAt;
  final CurrencyEntity currency;
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

  ForexEntity copyWith({
    String id,
    int unit,
    double buying,
    double selling,
    String source,
    String sourceUrl,
    DateTime publishedAt,
    CurrencyEntity currency,
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
      ForexEntity(
        id: id ?? this.id,
        unit: unit ?? this.unit,
        buying: buying ?? this.buying,
        selling: selling ?? this.selling,
        source: source ?? this.source,
        sourceUrl: sourceUrl ?? this.sourceUrl,
        publishedAt: publishedAt ?? this.publishedAt,
        currency: currency ?? this.currency,
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

  String get formatttedDate =>
      DateFormat('dd MMMM, yyyy').format(publishedAt.toLocal());

  @override
  List<Object> get props => [
        id,
        unit,
        buying,
        selling,
        source,
        sourceUrl,
        publishedAt,
        currency,
        createdAt,
        updatedAt,
        isLiked,
        isCommented,
        isViewed,
        isShared,
        likeCount,
        commentCount,
        viewCount,
        shareCount
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "unit": unit,
        "buying": buying,
        "selling": selling,
        "source": source,
        "source_url": sourceUrl,
        "publishedAt": publishedAt.toIso8601String(),
        "currency": currency.toMap(),
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
