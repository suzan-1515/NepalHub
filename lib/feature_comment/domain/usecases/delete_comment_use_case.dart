import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class DeleteCommentUseCase
    implements UseCase<CommentEntity, DeleteCommentUseCaseParams> {
  final Repository _repository;

  DeleteCommentUseCase(this._repository);

  @override
  Future<CommentEntity> call(DeleteCommentUseCaseParams params) {
    try {
      return this._repository.deleteComment(
            comment: params.commentEntity,
          );
    } catch (e) {
      log('DeleteCommentUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class DeleteCommentUseCaseParams extends Equatable {
  final CommentEntity commentEntity;

  DeleteCommentUseCaseParams({@required this.commentEntity});

  @override
  List<Object> get props => [commentEntity];
}
