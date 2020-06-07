import 'package:flutter/widgets.dart';

class PostMetaModel {
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int viewCount;
  final String postId;
  bool isUserLiked;
  bool isUserShared;
  bool isUserViewed;
  bool isUserCommented;
  bool isUserBookmarked;
  List<PostMetaActivityModel> activities = List<PostMetaActivityModel>();

  PostMetaModel(
      {@required this.likeCount,
      @required this.commentCount,
      @required this.shareCount,
      @required this.viewCount,
      @required this.postId,
      @required this.isUserLiked,
      @required this.isUserShared,
      @required this.isUserViewed,
      @required this.isUserCommented,
      @required this.isUserBookmarked,
      @required this.activities});

  toJson() => <String, dynamic>{
        'like_count': this.likeCount,
        'comment_count': this.commentCount,
        'view_count': this.viewCount,
        'share_count': this.shareCount,
      };
}

class PostMetaActivityModel {
  final String id;
  final String postId;
  final String userId;
  final String metaName;
  final String timestamp;

  PostMetaActivityModel(
      this.id, this.postId, this.userId, this.metaName, this.timestamp);

  factory PostMetaActivityModel.fromJson(Map<String, dynamic> json) =>
      PostMetaActivityModel(
        json['id'],
        json['post_id'],
        json['userId'],
        json['metaName'],
        json['timestamp'],
      );

  toJson() => <String, dynamic>{
        'id': this.id,
        'post_id': this.postId,
        'userId': this.userId,
        'metaName': this.metaName,
        'timestamp': this.timestamp
      };
}
