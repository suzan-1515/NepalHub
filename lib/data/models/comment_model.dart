import 'package:samachar_hub/data/models/user_model.dart';

class CommentModel {
  final String id;
  final String postId;
  final UserModel user;
  final String comment;
  final int likesCount;
  final String timestamp;
  final String updatedAt;

  CommentModel(this.id, this.postId, this.user, this.comment, this.likesCount,
      this.timestamp,
      {this.updatedAt});

  toJson() => <String, dynamic>{
        'id': this.id,
        'post_id': this.postId,
        'user': this.user.toJson(),
        'comment': this.comment,
        'like_count': this.likesCount,
        'timestamp': this.timestamp,
      };
}
