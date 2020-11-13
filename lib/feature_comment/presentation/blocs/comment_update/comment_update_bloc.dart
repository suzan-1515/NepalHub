import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/usecases.dart';

part 'comment_update_event.dart';
part 'comment_update_state.dart';

class CommentUpdateBloc extends Bloc<CommentUpdateEvent, CommentUpdateState> {
  final UseCase _editCommentUseCase;
  CommentUpdateBloc({@required UseCase editCommentUseCase})
      : _editCommentUseCase = editCommentUseCase,
        assert(
            editCommentUseCase != null, 'UpdateCommentUseCase cannot be null'),
        super(CommentUpdateInitialState());

  @override
  Stream<CommentUpdateState> mapEventToState(
    CommentUpdateEvent event,
  ) async* {
    if (event is UpdateCommentEvent) {
      yield* _mapUpdateEventToState(event);
    } else if (event is EditCommentEvent) {
      yield* _mapEditEventToState(event);
    }
  }

  Stream<CommentUpdateState> _mapUpdateEventToState(
    UpdateCommentEvent event,
  ) async* {
    if (state is CommentUpdateProgressState) return;
    yield CommentUpdateProgressState();
    try {
      final CommentEntity commentEntity = await _editCommentUseCase.call(
        UpdateCommentUseCaseParams(
          commentEntity: event.comment,
        ),
      );
      if (commentEntity != null)
        yield CommentUpdateSuccessState(comment: commentEntity);
      else
        yield CommentUpdateErrorState(message: 'Unable to update comment.');
    } catch (e) {
      log('Comment edit error: ', error: e);
      yield CommentUpdateErrorState(message: 'Unable to update comment.');
    }
  }

  Stream<CommentUpdateState> _mapEditEventToState(
    EditCommentEvent event,
  ) async* {
    yield CommentEditState(comment: event.comment);
  }
}
