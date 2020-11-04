import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/like_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unlike_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final UseCase _likeNewsFeedUseCase;
  final UseCase _unLikeNewsFeedUseCase;

  StreamSubscription _feedEventStreamSubscription;

  LikeUnlikeBloc({
    @required UseCase likeNewsFeedUseCase,
    @required UseCase unLikeNewsFeedUseCase,
  })  : _likeNewsFeedUseCase = likeNewsFeedUseCase,
        _unLikeNewsFeedUseCase = unLikeNewsFeedUseCase,
        super(NewsLikeInitialState()) {
    this._feedEventStreamSubscription =
        GetIt.I.get<EventBus>().on<NewsChangeEvent>().listen((event) {
      switch (event.eventType) {
        case 'like':
          add(UpdateLikeEvent(feed: event.data));
          break;
        case 'unlike':
          add(UpdateUnlikeEvent(feed: event.data));
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _feedEventStreamSubscription?.cancel();
    return super.close();
  }

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
    } else if (event is UpdateLikeEvent) {
      yield* _mapUpdateLikeEventToState(event);
    } else if (event is UpdateUnlikeEvent) {
      yield* _mapUpdateUnLikeEventToState(event);
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

  Stream<LikeUnlikeState> _mapUpdateLikeEventToState(
    UpdateLikeEvent event,
  ) async* {
    try {
      if (event.feed.isLiked) return;
      final feed = event.feed
          .copyWith(isLiked: true, likeCount: event.feed.likeCount + 1);
      yield NewsLikeSuccessState(feed: feed);
    } catch (e) {
      log('Update news like error: ', error: e);
    }
  }

  Stream<LikeUnlikeState> _mapUpdateUnLikeEventToState(
    UpdateUnlikeEvent event,
  ) async* {
    try {
      if (!event.feed.isLiked) return;
      final feed = event.feed
          .copyWith(isLiked: false, likeCount: event.feed.likeCount - 1);
      yield NewsUnLikeSuccessState(feed: feed);
    } catch (e) {
      log('Update news unlike error: ', error: e);
    }
  }
}
