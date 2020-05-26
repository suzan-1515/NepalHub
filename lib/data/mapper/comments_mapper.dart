import 'package:samachar_hub/data/api/response/comments_firestore_response.dart';
import 'package:samachar_hub/data/models/comment_model.dart';

class CommentsMapper {
  static CommentsModel fromCommentsFirestore(CommentsFirestoreResponse response,
      List<CommentFirestoreResponse> commentsResponse) {
    return CommentsModel(
        response.postId, response.likesCount, response.commentsCount,
        comments:
            commentsResponse?.map((e) => fromCommentFirestore(e))?.toList());
  }

  static CommentModel fromCommentFirestore(CommentFirestoreResponse response) {
    return CommentModel(response.id, response.user, response.comment,
        response.likesCount, response.timestamp,
        updatedAt: response.relativeTimestamp);
  }
}
