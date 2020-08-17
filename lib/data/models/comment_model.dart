import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samachar_hub/data/models/user_model.dart';

class CommentModel {
  final String id;
  final String postId;
  final UserModel user;
  final String comment;
  final ValueNotifier<int> likeCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> likeNotifier = ValueNotifier<bool>(false);
  final String timestamp;
  final String updatedAt;
  final List<String> likedUsers;

  CommentModel(this.id, this.postId, this.user, this.comment, int likesCount,
      this.timestamp, this.likedUsers, bool isLiked,
      {this.updatedAt}) {
    this.likeCountNotifier.value = likesCount ?? 0;
    this.likeNotifier.value = isLiked;
  }

  int get likesCount => likeCountNotifier.value;
  bool get isLiked => likeNotifier.value;

  int get likeCount => likeCountNotifier.value;
  String get likeCountFormatted =>
      NumberFormat.compact().format(likeCountNotifier.value);

  set like(bool value) {
    this.likeNotifier.value = value;
    this.likeCountNotifier.value = value
        ? likeCountNotifier.value = likesCount + 1
        : likeCountNotifier.value = likesCount - 1;
  }

  toJson() => <String, dynamic>{
        'id': this.id,
        'post_id': this.postId,
        'user': this.user.toJson(),
        'comment': this.comment,
        'like_count': this.likesCount,
        'liked_users': this.likedUsers,
        'timestamp': this.timestamp,
      };
}

class CommentLikeModel {
  final String id;
  final String userId;
  final String timestamp;

  CommentLikeModel(this.id, this.userId, this.timestamp);

  toJson() => <String, dynamic>{
        'id': this.id,
        'userId': this.userId,
        'timestamp': this.timestamp,
      };
}
