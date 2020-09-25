import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_comment/domain/entities/comment_entity.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_comment/domain/usecases/get_comments_use_case.dart';
import 'package:samachar_hub/feature_comment/presentation/models/comment_model.dart';
import 'package:samachar_hub/feature_comment/utils/comment_entity_extension.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final UseCase _getCommentsUseCase;
  final String _threadId;
  final CommentThreadType _threadType;
  final String _threadTitle;
  final String _likeCount;
  final String _commentCount;

  CommentBloc(
      {@required UseCase getCommentsUseCase,
      @required String threadId,
      @required String threadTitle,
      @required String likeCount,
      @required String commentCount,
      @required CommentThreadType threadType})
      : _getCommentsUseCase = getCommentsUseCase,
        _threadId = threadId,
        _threadType = threadType,
        _threadTitle = threadTitle,
        _likeCount = likeCount,
        _commentCount = commentCount,
        assert(getCommentsUseCase != null, 'GetCommentUseCase cannot be null'),
        assert(threadId != null && threadId.isNotEmpty,
            'Thread id cannot be null or empty'),
        assert(threadType != null, 'Comment thread type cannot be null'),
        super(CommentInitial());

  int _page = 1;

  String get threadId => _threadId;
  String get threadTitle => _threadTitle;
  String get likeCount => _likeCount;
  String get commentCount => _commentCount;
  CommentThreadType get threadType => _threadType;
  int get page => _page;

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is GetCommentsEvent) {
      yield* _mapGetCommentsEventToState(event);
    } else if (event is RefreshCommentsEvent) {
      yield* _mapRefreshCommentsEventToState(event);
    } else if (event is LoadMoreCommentsEvent) {
      yield* _mapLoadMoreCommentsEventToState(event);
    }
  }

  Stream<CommentState> _mapGetCommentsEventToState(
      GetCommentsEvent event) async* {
    if (state is CommentLoading) return;
    yield CommentLoading();
    try {
      _page = 1;
      List<CommentEntity> comments = await _getCommentsUseCase.call(
        GetCommentsUseCaseParams(
          threadId: _threadId,
          threadType: _threadType,
          page: page,
        ),
      );
      if (comments == null || comments.isEmpty) {
        yield CommentLoadEmpty(
            message:
                'Comment has not posted yet. Be the first to post comment?');
      } else
        yield CommentLoadSuccess(comments.toUIModels);
    } catch (e) {
      log('Comment load error of thread id: $_threadId and thread type: $_threadType.',
          error: e);
      yield CommentLoadError(
          message:
              'Unable to load comments. Make sure you are connected to Internet.');
    }
  }

  Stream<CommentState> _mapRefreshCommentsEventToState(
      RefreshCommentsEvent event) async* {
    try {
      List<CommentEntity> comments = await _getCommentsUseCase.call(
        GetCommentsUseCaseParams(
          threadId: _threadId,
          threadType: _threadType,
          page: 1,
        ),
      );
      if (comments != null || comments.isNotEmpty) {
        _page = 1;
        yield CommentLoadSuccess(comments.toUIModels);
      }
    } catch (e) {
      log('Comment refresh error of thread id: $_threadId and thread type: $_threadType.',
          error: e);
      yield CommentError(
          message:
              'Unable to refresh comments. Make sure you are connected to Internet.');
    }
  }

  Stream<CommentState> _mapLoadMoreCommentsEventToState(
      LoadMoreCommentsEvent event) async* {
    if (state is CommentMoreLoading) return;
    final currentState = state;
    yield CommentMoreLoading();
    try {
      List<CommentEntity> comments = await _getCommentsUseCase.call(
        GetCommentsUseCaseParams(
          threadId: _threadId,
          threadType: _threadType,
          page: page + 1,
        ),
      );
      if (comments == null || comments.isEmpty) {
        if (currentState is CommentLoadSuccess) {
          yield currentState.copyWith(hasMore: false);
        } else {
          _page = 1;
          yield CommentLoadEmpty(
              message:
                  'Comment has not posted yet. Be the first to post comment?');
        }
      } else {
        _page = _page + 1;
        if (currentState is CommentLoadSuccess) {
          yield currentState.copyWith(
              comments: currentState.comments + comments.toUIModels);
        } else
          yield CommentLoadSuccess(comments.toUIModels);
      }
    } catch (e) {
      log('Comment load more error of thread id: $_threadId and thread type: $_threadType.',
          error: e);
      yield CommentError(
          message:
              'Unable to load comments. Make sure you are connected to Internet.');
    }
  }
}
