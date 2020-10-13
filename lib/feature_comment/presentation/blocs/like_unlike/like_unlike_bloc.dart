import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/like_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/unlike_comment_use_case.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeCommentUseCase;
  final UseCase _unlikeCommentUseCase;
  final CommentUIModel _commentUIModel;
  LikeUnlikeBloc(
      {@required UseCase likeCommentUseCase,
      @required UseCase unlikeCommentUseCase,
      @required CommentUIModel commentUIModel})
      : _likeCommentUseCase = likeCommentUseCase,
        _unlikeCommentUseCase = unlikeCommentUseCase,
        _commentUIModel = commentUIModel,
        super(InitialState());

  CommentUIModel get commentUIModel => _commentUIModel;

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    if (state is InProgressState) return;
    if (event is LikeEvent) {
      try {
        final CommentEntity commentEntity = await _likeCommentUseCase.call(
          LikeCommentUseCaseParams(
            commentEntity: commentUIModel.comment,
          ),
        );
        if (commentEntity != null) {
          _commentUIModel.comment = _commentUIModel.comment.copyWith(
              isLiked: commentEntity.isLiked,
              likeCount: commentEntity.likeCount,
              isCommented: commentEntity.isCommented,
              commentCount: commentEntity.commentCount);
        }
        yield LikeSuccessState();
      } catch (e) {
        log('Comment like error: ', error: e);
        yield ErrorState(message: 'Unable to like.');
      }
    } else if (event is UnlikeEvent) {
      try {
        final CommentEntity commentEntity = await _unlikeCommentUseCase.call(
          UnlikeCommentUseCaseParams(
            commentEntity: commentUIModel.comment,
          ),
        );
        if (commentEntity != null) {
          _commentUIModel.comment = _commentUIModel.comment.copyWith(
              isLiked: commentEntity.isLiked,
              likeCount: commentEntity.likeCount,
              isCommented: commentEntity.isCommented,
              commentCount: commentEntity.commentCount);
        }
        yield UnlikeSuccessState();
      } catch (e) {
        log('Comment unlikelike error: ', error: e);
        yield ErrorState(message: 'Unable to unlike.');
      }
    }
  }
}
