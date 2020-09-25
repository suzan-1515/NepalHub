import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class UnlikeCommentUseCase
    implements UseCase<CommentEntity, UnlikeCommentUseCaseParams> {
  final Repository _repository;

  UnlikeCommentUseCase(this._repository);

  @override
  Future<CommentEntity> call(UnlikeCommentUseCaseParams params) {
    try {
      return this._repository.unlikeComment(
            comment: params.commentEntity,
          );
    } catch (e) {
      log('UnlikeCommentUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UnlikeCommentUseCaseParams extends Equatable {
  final CommentEntity commentEntity;

  UnlikeCommentUseCaseParams({@required this.commentEntity});

  @override
  List<Object> get props => [commentEntity];
}
