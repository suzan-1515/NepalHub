import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/like_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unlike_news_use_case.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeNewsFeedUseCase;
  final UseCase _unLikeNewsFeedUseCase;

  LikeUnlikeBloc({
    @required UseCase likeNewsFeedUseCase,
    @required UseCase unLikeNewsFeedUseCase,
  })  : _likeNewsFeedUseCase = likeNewsFeedUseCase,
        _unLikeNewsFeedUseCase = unLikeNewsFeedUseCase,
        super(NewsLikeInitialState());

  @override
  Stream<Transition<LikeUnlikeEvent, LikeUnlikeState>> transformEvents(
      Stream<LikeUnlikeEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    if (event is LikeEvent) {
      yield* _mapLikeEventToState(event);
    } else if (event is UnlikeEvent) {
      yield* _mapUnLikeEventToState(event);
    }
  }

  Stream<LikeUnlikeState> _mapLikeEventToState(
    LikeEvent event,
  ) async* {
    if (state is NewsLikeInProgressState) return;
    yield NewsLikeInProgressState();
    try {
      final NewsFeedEntity newsFeedEntity = await _likeNewsFeedUseCase
          .call(LikeNewsUseCaseParams(feed: event.feed));
      if (newsFeedEntity != null)
        yield NewsLikeSuccessState(feed: newsFeedEntity);
      else
        yield NewsLikeErrorState(message: 'Unable to like.');
    } catch (e) {
      log('News like error.', error: e);
      yield NewsLikeErrorState(message: 'Unable to like.');
    }
  }

  Stream<LikeUnlikeState> _mapUnLikeEventToState(
    UnlikeEvent event,
  ) async* {
    if (state is NewsLikeInProgressState) return;
    yield NewsLikeInProgressState();
    try {
      final NewsFeedEntity newsFeedEntity = await _unLikeNewsFeedUseCase
          .call(UnlikeNewsUseCaseParams(feed: event.feed));
      if (newsFeedEntity != null)
        yield NewsUnLikeSuccessState(feed: newsFeedEntity);
      else
        yield NewsLikeErrorState(message: 'Unable to unlike.');
    } catch (e) {
      log('News unlike error.', error: e);
      yield NewsLikeErrorState(message: 'Unable to unlike.');
    }
  }
}
