import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/utils/helper.dart';

class CommentFirestoreResponse {
  final String id;
  final String postId;
  final UserModel user;
  final String comment;
  final int likesCount;
  final List<String> likedUsers;
  final String timestamp;

  CommentFirestoreResponse(this.id, this.postId, this.user, this.comment,
      this.likesCount, this.likedUsers, this.timestamp);

  String get relativeTimestamp => relativeTimeString(DateTime.parse(timestamp));

  factory CommentFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      CommentFirestoreResponse(
        json['id'],
        json['post_id'],
        UserModel.fromJson(json['user'] as Map<String, dynamic>),
        json['comment'],
        json['like_count'],
        json['liked_users'].cast<String>(),
        json['timestamp'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'post_id': this.postId,
        'user': this.user.toJson(),
        'comment': this.comment,
        'like_count': this.likesCount,
        'liked_users': this.likedUsers,
        'timestamp': this.timestamp,
      };
}

class CommentLikeFirestoreResponse {
  final String id;
  final String userId;
  final String timestamp;

  CommentLikeFirestoreResponse(this.id, this.userId, this.timestamp);

  String get relativeTimestamp => relativeTimeString(DateTime.parse(timestamp));

  factory CommentLikeFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      CommentLikeFirestoreResponse(
        json['id'],
        json['user_id'],
        json['timestamp'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'user_id': this.userId,
        'timestamp': this.timestamp,
      };
}
