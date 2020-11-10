import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/follow_news_topic_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unfollow_news_topic_use_case.dart';

part 'follow_un_follow_event.dart';
part 'follow_un_follow_state.dart';

class TopicFollowUnFollowBloc
    extends Bloc<TopicFollowUnFollowEvent, TopicFollowUnFollowState> {
  final UseCase _followNewsTopicUseCase;
  final UseCase _unFollowNewsTopicUseCase;

  TopicFollowUnFollowBloc({
    @required UseCase followNewsTopicUseCase,
    @required UseCase unFollowNewsTopicUseCase,
  })  : _followNewsTopicUseCase = followNewsTopicUseCase,
        _unFollowNewsTopicUseCase = unFollowNewsTopicUseCase,
        super(TopicFollowInitialState());

  @override
  Stream<Transition<TopicFollowUnFollowEvent, TopicFollowUnFollowState>>
      transformEvents(Stream<TopicFollowUnFollowEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<TopicFollowUnFollowState> mapEventToState(
    TopicFollowUnFollowEvent event,
  ) async* {
    if (event is TopicFollowEvent) {
      yield* _mapFollowEventToState(event);
    } else if (event is TopicUnFollowEvent) {
      yield* _mapUnFollowEventToState(event);
    }
  }

  Stream<TopicFollowUnFollowState> _mapFollowEventToState(
    TopicFollowEvent event,
  ) async* {
    if (state is TopicFollowInProgressState) return;
    yield TopicFollowInProgressState();
    try {
      final NewsTopicEntity newsTopicEntity = await _followNewsTopicUseCase
          .call(FollowNewsTopicUseCaseParams(topic: event.topic));
      if (newsTopicEntity != null)
        yield TopicFollowSuccessState(topic: newsTopicEntity);
      else
        yield TopicFollowErrorState(message: 'Unable to follow.');
    } catch (e) {
      log('News topic follow error.', error: e);
      yield TopicFollowErrorState(message: 'Unable to follow.');
    }
  }

  Stream<TopicFollowUnFollowState> _mapUnFollowEventToState(
    TopicUnFollowEvent event,
  ) async* {
    if (state is TopicFollowInProgressState) return;
    yield TopicFollowInProgressState();
    try {
      final NewsTopicEntity newsTopicEntity = await _unFollowNewsTopicUseCase
          .call(UnFollowNewsTopicUseCaseParams(topic: event.topic));
      if (newsTopicEntity != null)
        yield TopicUnFollowSuccessState(topic: newsTopicEntity);
      else
        yield TopicFollowErrorState(message: 'Unable to unfollow.');
    } catch (e) {
      log('News topic unfollow error.', error: e);
      yield TopicFollowErrorState(message: 'Unable to unfollow.');
    }
  }
}
