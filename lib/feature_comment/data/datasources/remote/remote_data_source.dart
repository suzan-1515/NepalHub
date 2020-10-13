import 'package:samachar_hub/feature_comment/data/models/comment_model.dart';

mixin RemoteDataSource {
  Future<List<CommentModel>> fetchComments(
      {String threadId, String threadType, int page, String token});
  Future<CommentModel> postComment(
      {String threadId, String threadType, String comment, String token});
  Future<CommentModel> likeComment({String commentId, String token});
  Future<CommentModel> unlikeComment({String commentId, String token});
  Future<CommentModel> deleteComment({String commentId, String token});
  Future<CommentModel> updateComment(
      {String commentId, String comment, String token});
}
