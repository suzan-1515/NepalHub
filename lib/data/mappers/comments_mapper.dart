import 'package:samachar_hub/data/api/response/comments_firestore_response.dart';
import 'package:samachar_hub/data/models/comment_model.dart';

class CommentsMapper {
  static CommentModel fromCommentFirestore(CommentFirestoreResponse response,String userId) {
    return CommentModel(response.id, response.postId, response.user,
        response.comment, response.likesCount, response.timestamp,response.user.uId == userId,
        updatedAt: response.relativeTimestamp);
  }
}
