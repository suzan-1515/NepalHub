import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/like_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/unlike_comment_use_case.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class CommentLikeUnlikeBloc
    extends Bloc<CommentLikeUnlikeEvent, CommentLikeUnlikeState> {
  final UseCase _likeCommentUseCase;
  final UseCase _unlikeCommentUseCase;
  CommentLikeUnlikeBloc(
      {@required UseCase likeCommentUseCase,
      @required UseCase unlikeCommentUseCase})
      : _likeCommentUseCase = likeCommentUseCase,
        _unlikeCommentUseCase = unlikeCommentUseCase,
        super(CommentLikeInitialState());

  @override
  Stream<CommentLikeUnlikeState> mapEventToState(
    CommentLikeUnlikeEvent event,
  ) async* {
    if (state is CommentLikeInProgressState) return;
    if (event is CommentLikeEvent) {
      try {
        final CommentEntity commentEntity = await _likeCommentUseCase.call(
          LikeCommentUseCaseParams(
            commentEntity: event.comment,
          ),
        );
        if (commentEntity != null)
          yield CommentLikeSuccessState(comment: commentEntity);
        else
          yield CommentErrorState(message: 'Unable to like.');
      } catch (e) {
        log('Comment like error: ', error: e);
        yield CommentErrorState(message: 'Unable to like.');
      }
    } else if (event is CommentUnlikeEvent) {
      try {
        final CommentEntity commentEntity = await _unlikeCommentUseCase.call(
          UnlikeCommentUseCaseParams(
            commentEntity: event.comment,
          ),
        );
        if (commentEntity != null)
          yield CommentUnlikeSuccessState(comment: commentEntity);
        else
          yield CommentErrorState(message: 'Unable to unlike.');
      } catch (e) {
        log('Comment unlikelike error: ', error: e);
        yield CommentErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
