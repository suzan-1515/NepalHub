import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/delete_comment_use_case.dart';

part 'delete_state.dart';

class CommentDeleteCubit extends Cubit<CommentDeleteState> {
  final UseCase _deleteCommentUseCase;
  CommentDeleteCubit({@required UseCase deleteCommentUseCase})
      : _deleteCommentUseCase = deleteCommentUseCase,
        super(CommentDeleteInitialState());

  delete(CommentEntity comment) async {
    if (state is CommentDeleteInProgressState) return;
    emit(CommentDeleteInProgressState());
    try {
      final CommentEntity commentEntity = await _deleteCommentUseCase.call(
        DeleteCommentUseCaseParams(
          commentEntity: comment,
        ),
      );
      if (commentEntity != null)
        emit(CommentDeleteSuccessState(comment: commentEntity));
      else
        emit(CommentDeleteErrorState(message: 'Unable to delete comment.'));
    } catch (e) {
      log('Comment delete error: ', error: e);
      emit(CommentDeleteErrorState(message: 'Unable to delete comment.'));
    }
  }
}
