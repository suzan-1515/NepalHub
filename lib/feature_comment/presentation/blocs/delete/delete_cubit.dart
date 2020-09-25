import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/delete_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';

part 'delete_state.dart';

class CommentDeleteCubit extends Cubit<CommentDeleteState> {
  final UseCase _deleteCommentUseCase;
  final CommentUIModel _commentUIModel;
  CommentDeleteCubit(
      {@required UseCase deleteCommentUseCase,
      @required CommentUIModel commentUIModel})
      : _deleteCommentUseCase = deleteCommentUseCase,
        _commentUIModel = commentUIModel,
        super(InitialState());

  delete() async {
    if (state is InProgressState) return;
    emit(InProgressState());
    try {
      final CommentEntity commentEntity = await _deleteCommentUseCase.call(
        DeleteCommentUseCaseParams(
          commentEntity: _commentUIModel.comment,
        ),
      );
      emit(SuccessState(message: 'Comment deleted.'));
    } catch (e) {
      log('Comment delete error: ', error: e);
      emit(ErrorState(message: 'Unable to delete comment.'));
    }
  }
}
