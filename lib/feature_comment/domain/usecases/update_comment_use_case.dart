import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class UpdateCommentUseCase
    implements UseCase<CommentEntity, UpdateCommentUseCaseParams> {
  final Repository _repository;

  UpdateCommentUseCase(this._repository);

  @override
  Future<CommentEntity> call(UpdateCommentUseCaseParams params) {
    try {
      return this._repository.updateComment(
            comment: params.commentEntity,
          );
    } catch (e) {
      log('UpdateCommentUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class UpdateCommentUseCaseParams extends Equatable {
  final CommentEntity commentEntity;

  UpdateCommentUseCaseParams({@required this.commentEntity});

  @override
  List<Object> get props => [commentEntity];
}
