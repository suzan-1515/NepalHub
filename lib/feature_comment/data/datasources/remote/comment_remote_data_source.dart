import 'package:flutter/foundation.dart';
import 'package:samachar_hub/feature_comment/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_comment/data/models/comment_model.dart';
import 'package:samachar_hub/feature_comment/data/services/remote_service.dart';

class CommentRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  CommentRemoteDataSource(this._remoteService);
  @override
  Future<CommentModel> deleteComment(
      {@required String commentId, String token}) async {
    var response =
        await _remoteService.deleteComment(commentId: commentId, token: token);

    return CommentModel.fromMap(response);
  }

  @override
  Future<List<CommentModel>> fetchComments(
      {@required String threadId,
      @required String threadType,
      @required int page,
      @required String token}) async {
    var response = await _remoteService.fetchComments(
        threadId: threadId, threadType: threadType, page: page, token: token);
    final List<CommentModel> comments =
        response.map<CommentModel>((e) => CommentModel.fromMap(e)).toList();

    return comments;
  }

  @override
  Future<CommentModel> likeComment(
      {@required String commentId, @required String token}) async {
    var response =
        await _remoteService.likeComment(commentId: commentId, token: token);

    return CommentModel.fromMap(response);
  }

  @override
  Future<CommentModel> postComment(
      {@required String threadId,
      @required String threadType,
      @required String comment,
      @required String token}) {
    throw UnimplementedError();
  }

  @override
  Future<CommentModel> unlikeComment(
      {@required String commentId, @required String token}) async {
    var response =
        await _remoteService.unlikeComment(commentId: commentId, token: token);

    return CommentModel.fromMap(response);
  }

  @override
  Future<CommentModel> updateComment(
      {@required String commentId,
      @required String comment,
      @required String token}) async {
    var response = await _remoteService.updateComment(
        commentId: commentId, comment: comment, token: token);

    return CommentModel.fromMap(response);
  }
}
