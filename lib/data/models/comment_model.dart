import 'package:samachar_hub/data/api/response/news_firestore_response.dart';

class CommentsModel {
  final String id;
  List<CommentModel> comments;
  final int likesCount;
  final int totalCount;

  CommentsModel(this.id, this.likesCount, this.totalCount, {this.comments});
}

class CommentModel {
  final String id;
  final User user;
  final String comment;
  final int likesCount;
  final String timestamp;
  final String updatedAt;

  CommentModel(this.id, this.user, this.comment, this.likesCount,
      this.timestamp, {this.updatedAt});

  toJson() => <String, dynamic>{
        'id': this.id,
        'user': this.user.toJson(),
        'comment': this.comment,
        'likes_count': this.likesCount,
        'timestamp': this.timestamp,
      };
}
