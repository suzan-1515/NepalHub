import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_stats/domain/entities/thread_stats_entity.dart';

class ThreadStatsModel extends ThreadStatsEntity {
  ThreadStatsModel({
    @required int likeCount,
    @required int viewCount,
    @required int shareCount,
    @required int commentCount,
    @required int bookmarkCount,
    @required int followerCount,
  }) : super(
            likeCount: likeCount,
            viewCount: viewCount,
            shareCount: shareCount,
            commentCount: commentCount,
            bookmarkCount: bookmarkCount,
            followerCount: followerCount);

  factory ThreadStatsModel.fromJson(String str) =>
      ThreadStatsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ThreadStatsModel.fromMap(Map<String, dynamic> json) =>
      ThreadStatsModel(
        likeCount: json["like_count"],
        viewCount: json["view_count"],
        shareCount: json['share_count'],
        commentCount: json['comment_count'],
        bookmarkCount: json['bookmark_count'],
        followerCount: json['follower_count'],
      );

  Map<String, dynamic> toMap() => {
        "like_count": likeCount,
        "view_count": viewCount,
        "share_count": shareCount,
        "comment_count": commentCount,
        "bookmark_count": bookmarkCount,
        "follower_count": followerCount,
      };
}
