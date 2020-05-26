import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/common/manager/managers.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/api/response/comments_firestore_response.dart';
import 'package:samachar_hub/data/mapper/comments_mapper.dart';
import 'package:samachar_hub/data/models/comment_model.dart';
import 'package:samachar_hub/pages/comment/comment_firestore_service.dart';

class CommentRepository {
  final CommentFirestoreService _commentService;
  final AnalyticsService _analyticsService;
  final AuthenticationController _authenticationController;

  static const int DATA_LIMIT = 20;

  CommentRepository(CommentFirestoreService commentService,
      this._analyticsService, this._authenticationController)
      : this._commentService = commentService;

  Future<CommentModel> postComment(
      {@required String postId, @required CommentModel commentModel}) {
    var meta = {
      'id': postId,
      'comments_count': FieldValue.increment(1),
    };
    var data = commentModel.toJson();
    return _commentService
        .saveComment(
            postId: postId,
            commentId: commentModel.id,
            commentMetaData: meta,
            commentData: data)
        .then((value) {
      _analyticsService.logCommentPosted(
          userId: _authenticationController.currentUser.uId, postId: postId);
      return commentModel;
    });
  }

  Future<void> postCommentLike(
      {@required String postId, @required String commentId}) async {
    return _commentService
        .updateCommentLikes(postId: postId, commentId: commentId)
        .then((value) {
      _analyticsService.logCommentLiked(
          userId: _authenticationController.currentUser.uId, postId: postId);
    });
  }

  Future<CommentsModel> getComments({@required String postId, String after}) {
    return _commentService
        .fetchCommentsMeta(postId: postId)
        .then((value) async {
      if (value.exists) {
        final CommentsFirestoreResponse commentsResponse =
            CommentsFirestoreResponse.fromJson(value.data);
        return await _commentService
            .fetchComments(postId: postId, limit: DATA_LIMIT, after: after)
            .then((onValue) {
          if (onValue != null &&
              onValue.documents != null &&
              onValue.documents.isNotEmpty) {
            return CommentsMapper.fromCommentsFirestore(
                commentsResponse,
                onValue.documents
                    .where((snapshot) => snapshot != null && snapshot.exists)
                    .map((snapshot) =>
                        CommentFirestoreResponse.fromJson(snapshot.data))
                    .toList());
          }

          return CommentsMapper.fromCommentsFirestore(commentsResponse, null);
        });
      }
      return null;
    }).then((value) {
      _analyticsService.logCommentFetched(
          userId: _authenticationController.currentUser.uId, postId: postId);
      return value;
    });
  }
}
