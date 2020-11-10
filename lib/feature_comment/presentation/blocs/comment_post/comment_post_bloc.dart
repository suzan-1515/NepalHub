import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/post_comment_use_case.dart';

part 'comment_post_event.dart';
part 'comment_post_state.dart';

class CommentPostBloc extends Bloc<CommentPostEvent, CommentPostState> {
  final UseCase _postCommentUseCase;
  final String _threadId;
  final CommentThreadType _threadType;
  CommentPostBloc(
      {@required UseCase postCommentUseCase,
      @required String threadId,
      @required threadType})
      : _postCommentUseCase = postCommentUseCase,
        _threadId = threadId,
        _threadType = threadType,
        assert(postCommentUseCase != null, 'PostCommentUseCase cannot be null'),
        assert(threadId != null && threadId.isNotEmpty,
            'Thread id cannot be null or empty'),
        assert(threadType != null, 'Comment thread type cannot be null'),
        super(CommentPostInitialState());

  String get threadId => _threadId;
  CommentThreadType get threadType => _threadType;

  @override
  Stream<CommentPostState> mapEventToState(
    CommentPostEvent event,
  ) async* {
    if (state is CommentPostProgressState) return;
    if (event is PostCommentEvent) {
      yield CommentPostProgressState();
      try {
        final CommentEntity commentEntity = await _postCommentUseCase.call(
          PostCommentUseCaseParams(
            threadId: threadId,
            threadType: threadType,
            comment: event.comment,
          ),
        );
        if (commentEntity != null)
          yield CommentPostSuccessState(comment: commentEntity);
        else
          yield CommentPostErrorState(message: 'Unable to post comment.');
      } catch (e) {
        log('Comment post error: ', error: e);
        yield CommentPostErrorState(message: 'Unable to post comment.');
      }
    }
  }
}
