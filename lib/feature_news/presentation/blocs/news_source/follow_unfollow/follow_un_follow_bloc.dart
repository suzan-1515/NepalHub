import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_source_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class SourceFollowUnFollowBloc
    extends Bloc<SourceFollowUnFollowEvent, SourceFollowUnFollowState> {
  final UseCase _followNewsSourceUseCase;
  final UseCase _unFollowNewsSourceUseCase;

  StreamSubscription _feedEventStreamSubscription;

  SourceFollowUnFollowBloc({
    @required UseCase followNewsSourceUseCase,
    @required UseCase unFollowNewsSourceUseCase,
  })  : _followNewsSourceUseCase = followNewsSourceUseCase,
        _unFollowNewsSourceUseCase = unFollowNewsSourceUseCase,
        super(SourceFollowInitialState()) {
    this._feedEventStreamSubscription =
        GetIt.I.get<EventBus>().on<NewsChangeEvent>().listen((event) {
      switch (event.eventType) {
        case 'source_follow':
          add(UpdateSourceFollowEvent(source: event.data));
          break;
        case 'source_unfollow':
          add(UpdateSourceUnfollowEvent(source: event.data));
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
  Stream<Transition<SourceFollowUnFollowEvent, SourceFollowUnFollowState>>
      transformEvents(Stream<SourceFollowUnFollowEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<SourceFollowUnFollowState> mapEventToState(
    SourceFollowUnFollowEvent event,
  ) async* {
    if (event is SourceFollowEvent) {
      yield* _mapFollowEventToState(event);
    } else if (event is SourceUnFollowEvent) {
      yield* _mapUnFollowEventToState(event);
    } else if (event is UpdateSourceFollowEvent) {
      yield* _mapUpdateFollowEventToState(event);
    } else if (event is UpdateSourceUnfollowEvent) {
      yield* _mapUpdateUnFollowEventToState(event);
    }
  }

  Stream<SourceFollowUnFollowState> _mapFollowEventToState(
    SourceFollowEvent event,
  ) async* {
    if (state is SourceFollowInProgressState) return;
    yield SourceFollowInProgressState();
    try {
      final NewsSourceEntity newsSourceEntity = await _followNewsSourceUseCase
          .call(FollowNewsSourceUseCaseParams(source: event.source));
      if (newsSourceEntity != null)
        yield SourceFollowSuccessState(source: newsSourceEntity);
      else
        yield SourceFollowErrorState(message: 'Unable to follow.');
    } catch (e) {
      log('News source follow load error.', error: e);
      yield SourceFollowErrorState(message: 'Unable to follow.');
    }
  }

  Stream<SourceFollowUnFollowState> _mapUnFollowEventToState(
    SourceUnFollowEvent event,
  ) async* {
    if (state is SourceFollowInProgressState) return;
    yield SourceFollowInProgressState();
    try {
      final NewsSourceEntity newsSourceEntity = await _unFollowNewsSourceUseCase
          .call(UnFollowNewsSourceUseCaseParams(source: event.source));
      if (newsSourceEntity != null)
        yield SourceUnFollowSuccessState(source: newsSourceEntity);
      else
        yield SourceFollowErrorState(message: 'Unable to unfollow.');
    } catch (e) {
      log('News sources unfollow error.', error: e);
      yield SourceFollowErrorState(message: 'Unable to unfollow.');
    }
  }

  Stream<SourceFollowUnFollowState> _mapUpdateFollowEventToState(
    UpdateSourceFollowEvent event,
  ) async* {
    try {
      if (event.source.isFollowed) return;
      final source = event.source.copyWith(
          isFollowed: true, followerCount: event.source.followerCount + 1);
      yield SourceFollowSuccessState(source: source);
    } catch (e) {
      log('Update source follow error: ', error: e);
    }
  }

  Stream<SourceFollowUnFollowState> _mapUpdateUnFollowEventToState(
    UpdateSourceUnfollowEvent event,
  ) async* {
    try {
      if (!event.source.isFollowed) return;
      final source = event.source.copyWith(
          isFollowed: false, followerCount: event.source.followerCount - 1);
      yield SourceUnFollowSuccessState(source: source);
    } catch (e) {
      log('Update source unfollow error: ', error: e);
    }
  }
}
