import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/comment_model.dart';
import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/services/comment_firestore_service.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:uuid/uuid.dart';

class CommentRepository {
  final CommentFirestoreService _commentService;
  final AnalyticsService _analyticsService;
  final PostMetaRepository _postMetaRepository;

  static const int DATA_LIMIT = 20;

  CommentRepository(
      this._commentService, this._postMetaRepository, this._analyticsService);

  Future<void> postComment(
      {@required String postId,
      @required UserModel user,
      @required String comment}) {
    var commentId = Uuid().v4();

    var data = {
      'id': commentId,
      'post_id': postId,
      'user': user.toJson(),
      'comment': comment,
      'like_count': 0,
      'liked_users': List<String>(),
      'timestamp': DateTime.now().toIso8601String(),
    };
    return _commentService
        .saveComment(commentId: commentId, commentData: data)
        .then((value) {
      return _postMetaRepository.postComment(postId: postId, userId: user.uId);
    });
  }

  Future<void> postCommentLike(
      {@required String postId,
      @required String userId,
      @required String commentId}) async {
    return _commentService
        .addCommentLike(
      commentId: commentId,
      userId: userId,
    )
        .then((value) {
      _analyticsService.logCommentLiked(postId: postId, commentId: commentId);
    });
  }

  Future<void> postCommentUnlike(
      {@required String postId,
      @required String userId,
      @required String commentId}) async {
    return _commentService
        .removeCommentLike(
      commentId: commentId,
      userId: userId,
    )
        .then((value) {
      _analyticsService.logCommentLikeRemoved(postId: postId);
    });
  }

  Stream<List<CommentModel>> getCommentsAsStream(
      {@required String postId, @required String userId}) {
    return _commentService
        .fetchCommentsAsStream(postId: postId, limit: DATA_LIMIT)
        .map((value) {
      if (value != null && value.isNotEmpty) {
        return value
            .map((response) =>
                CommentsMapper.fromCommentFirestore(response, userId))
            .toList();
      }
      return List<CommentModel>();
    });
  }

  Future<List<CommentModel>> getComments(
      {@required String postId, @required String userId, String after}) {
    return _commentService
        .fetchComments(postId: postId, limit: DATA_LIMIT, after: after)
        .then((value) {
      if (value != null && value.isNotEmpty) {
        return value
            .map((response) =>
                CommentsMapper.fromCommentFirestore(response, userId))
            .toList();
      }
      return List<CommentModel>();
    });
  }
}
