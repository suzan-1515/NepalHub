import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/util/helper.dart';

class CommentFirestoreResponse {
  final String id;
  final String postId;
  final UserModel user;
  final String comment;
  final int likesCount;
  final String timestamp;

  CommentFirestoreResponse(this.id, this.postId, this.user, this.comment,
      this.likesCount, this.timestamp);

  String get relativeTimestamp => relativeTimeString(DateTime.parse(timestamp));

  factory CommentFirestoreResponse.fromJson(Map<String, dynamic> json) =>
      CommentFirestoreResponse(
        json['id'],
        json['post_id'],
        UserModel.fromJson(json['user'] as Map<String, dynamic>),
        json['comment'],
        json['like_count'],
        json['timestamp'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'post_id': this.postId,
        'user': this.user.toJson(),
        'comment': this.comment,
        'like_count': this.likesCount,
        'timestamp': this.timestamp,
      };
}
