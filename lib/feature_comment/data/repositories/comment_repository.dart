import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_auth/data/repositories/auth_repository.dart';
import 'package:samachar_hub/feature_comment/data/datasources/remote/remote_data_source.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class CommentRepository with Repository {
  final RemoteDataSource _commentRemoteDataSource;
  final AnalyticsService _analyticsService;
  final AuthRepository _authRepository;

  CommentRepository(this._commentRemoteDataSource, this._analyticsService,
      this._authRepository);

  @override
  Future<CommentEntity> deleteComment({@required CommentEntity comment}) {
    return _commentRemoteDataSource
        .deleteComment(
      commentId: comment.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logCommentDelete(commentId: comment.id);
      return value;
    });
  }

  @override
  Future<List<CommentEntity>> getComments(
      {@required String threadId,
      @required CommentThreadType threadType,
      @required int page}) {
    return _commentRemoteDataSource.fetchComments(
      threadId: threadId,
      threadType: threadType.value,
      page: page,
      token: _authRepository.getUserToken(),
    );
  }

  @override
  Future<CommentEntity> likeComment({@required CommentEntity comment}) {
    return _commentRemoteDataSource
        .likeComment(
      commentId: comment.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logCommentLike(commentId: comment.id);
      return value;
    });
  }

  @override
  Future<CommentEntity> postComment(
      {@required String threadId,
      @required CommentThreadType threadType,
      @required String comment}) {
    return _commentRemoteDataSource
        .postComment(
      threadId: threadId,
      threadType: threadType.value,
      comment: comment,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logCommentPost(commentId: value.id);
      return value;
    });
  }

  @override
  Future<CommentEntity> unlikeComment({@required CommentEntity comment}) {
    return _commentRemoteDataSource
        .unlikeComment(
      commentId: comment.id,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logCommentUnlike(commentId: comment.id);
      return value;
    });
  }

  @override
  Future<CommentEntity> updateComment({@required CommentEntity comment}) {
    return _commentRemoteDataSource
        .updateComment(
      commentId: comment.id,
      comment: comment.comment,
      token: _authRepository.getUserToken(),
    )
        .then((value) {
      _analyticsService.logCommentUpdate(commentId: comment.id);
      return value;
    });
  }
}
