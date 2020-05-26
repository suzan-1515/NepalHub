import 'package:samachar_hub/data/api/response/news_firestore_response.dart';
import 'package:samachar_hub/util/helper.dart';

class CommentsFirestoreResponse {
  final String postId;
  final int likesCount;
  final int commentsCount;

  CommentsFirestoreResponse(this.postId, this.likesCount, this.commentsCount);

  factory CommentsFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      CommentsFirestoreResponse(
        json['post_id'],
        json['likes_count'] ?? 0,
        json['comments_count'] ?? 0,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'post_id': this.postId,
        'likes_count': this.likesCount,
        'comments_count': this.commentsCount,
      };
}

class CommentFirestoreResponse {
  final String id;
  final User user;
  final String comment;
  final int likesCount;
  final String timestamp;

  CommentFirestoreResponse(
      this.id, this.user, this.comment, this.likesCount, this.timestamp);

  String get relativeTimestamp => relativeTimeString(DateTime.parse(timestamp));

  factory CommentFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      CommentFirestoreResponse(
        json['id'],
        User.fromJson(json['user'] as Map<String, dynamic>),
        json['comment'],
        json['likes_count'],
        json['timestamp'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'user': this.user.toJson(),
        'comment': this.comment,
        'likes_count': this.likesCount,
        'timestamp': this.timestamp,
      };
}
