import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_auth/data/models/user_model.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    @required String id,
    @required String threadId,
    @required CommentThreadType threadType,
    @required String comment,
    @required bool isLiked,
    @required bool isCommented,
    @required int commentCount,
    @required int likeCount,
    @required UserModel user,
    @required DateTime createdAt,
    @required DateTime updatedAt,
  }) : super(
            id: id,
            threadId: threadId,
            threadType: threadType,
            comment: comment,
            isLiked: isLiked,
            isCommented: isCommented,
            commentCount: commentCount,
            likeCount: likeCount,
            user: user,
            createdAt: createdAt,
            updatedAt: updatedAt);
  factory CommentModel.fromJson(String str) =>
      CommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        id: json["id"].toString(),
        threadId: json["thread_id"],
        user: UserModel.fromMap(json["user"]),
        comment: json["comment"],
        threadType: (json["thread_type"] as String).toCommentThreadType,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isLiked: json["is_liked"],
        isCommented: json["is_commented"],
        commentCount: json["comment_count"],
        likeCount: json["like_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "thread_id": threadId,
        "user": (user as UserModel).toMap(),
        "comment": comment,
        "thread_type": threadType.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_liked": isLiked,
        "is_commented": isCommented,
        "comment_count": commentCount,
        "like_count": likeCount,
      };
}
