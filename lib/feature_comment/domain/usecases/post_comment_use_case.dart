import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class PostCommentUseCase
    implements UseCase<CommentEntity, PostCommentUseCaseParams> {
  final Repository _repository;

  PostCommentUseCase(this._repository);

  @override
  Future<CommentEntity> call(PostCommentUseCaseParams params) {
    try {
      return this._repository.postComment(
          comment: params.comment,
          threadId: params.threadId,
          threadType: params.threadType);
    } catch (e) {
      log('PostCommentUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class PostCommentUseCaseParams extends Equatable {
  final String threadId;
  final CommentThreadType threadType;
  final String comment;

  PostCommentUseCaseParams(
      {@required this.threadId,
      @required this.threadType,
      @required this.comment});

  @override
  List<Object> get props => [comment, threadId, threadType];
}
