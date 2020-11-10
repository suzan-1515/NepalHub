import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/feature_auth/domain/entities/user_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';

class CommentEntity extends Equatable {
  final String id;
  final String threadId;
  final CommentThreadType threadType;
  final String comment;
  final bool isLiked;
  final bool isCommented;
  final int commentCount;
  final int likeCount;
  final UserEntity user;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentEntity(
      {@required this.id,
      @required this.threadId,
      @required this.threadType,
      @required this.comment,
      @required this.isLiked,
      @required this.isCommented,
      @required this.commentCount,
      @required this.likeCount,
      @required this.user,
      @required this.createdAt,
      @required this.updatedAt});

  CommentEntity copyWith({
    String id,
    String threadId,
    CommentThreadType threadType,
    String comment,
    bool isLiked,
    bool isCommented,
    int commentCount,
    int likeCount,
    UserEntity user,
    DateTime updatedAt,
    DateTime createdAt,
  }) =>
      CommentEntity(
        id: id ?? this.id,
        threadId: threadId ?? this.threadId,
        threadType: threadType ?? this.threadType,
        comment: comment ?? this.comment,
        isLiked: isLiked ?? this.isLiked,
        isCommented: isCommented ?? this.isCommented,
        commentCount: commentCount ?? this.commentCount,
        likeCount: likeCount ?? this.likeCount,
        user: user ?? this.user,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object> get props => [
        id,
        threadId,
        threadType,
        comment,
        isLiked,
        isCommented,
        comment,
        user,
        likeCount,
        createdAt,
        updatedAt
      ];

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "thread_id": threadId,
        "user": user.toMap(),
        "comment": comment,
        "thread_type": threadType.value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_liked": isLiked,
        "is_commented": isCommented,
        "comment_count": commentCount,
        "like_count": likeCount,
      };

  @override
  bool get stringify => true;
}
