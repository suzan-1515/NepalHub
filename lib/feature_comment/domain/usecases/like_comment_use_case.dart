import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class LikeCommentUseCase
    implements UseCase<CommentEntity, LikeCommentUseCaseParams> {
  final Repository _repository;

  LikeCommentUseCase(this._repository);

  @override
  Future<CommentEntity> call(LikeCommentUseCaseParams params) {
    try {
      return this._repository.likeComment(
            comment: params.commentEntity,
          );
    } catch (e) {
      log('LikeCommentUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class LikeCommentUseCaseParams extends Equatable {
  final CommentEntity commentEntity;

  LikeCommentUseCaseParams({@required this.commentEntity});

  @override
  List<Object> get props => [commentEntity];
}
