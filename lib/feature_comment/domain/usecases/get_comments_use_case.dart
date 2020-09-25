import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/repositories/repository.dart';

class GetCommentsUseCase
    implements UseCase<List<CommentEntity>, GetCommentsUseCaseParams> {
  final Repository _repository;

  GetCommentsUseCase(this._repository);

  @override
  Future<List<CommentEntity>> call(GetCommentsUseCaseParams params) {
    try {
      return this._repository.getComments(
          page: params.page,
          threadId: params.threadId,
          threadType: params.threadType);
    } catch (e) {
      log('GetCommentsUseCase unsuccessful.', error: e);
      throw e;
    }
  }
}

class GetCommentsUseCaseParams extends Equatable {
  final String threadId;
  final CommentThreadType threadType;
  final int page;

  GetCommentsUseCaseParams(
      {@required this.threadId,
      @required this.threadType,
      @required this.page});

  @override
  List<Object> get props => [page, threadId, threadType];
}
