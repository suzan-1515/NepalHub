import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_topics_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';

part 'news_topic_event.dart';
part 'news_topic_state.dart';

class NewsTopicBloc extends Bloc<NewsTopicEvent, NewsTopicState> {
  final UseCase _newsTopicsUseCase;
  final UseCase _newsFollowedTopicsUseCase;

  NewsTopicBloc({
    @required getNewsTopicsUseCase,
    @required getNewsFollowedTopicsUseCase,
  })  : _newsTopicsUseCase = getNewsTopicsUseCase,
        _newsFollowedTopicsUseCase = getNewsFollowedTopicsUseCase,
        super(NewsTopicInitialState());

  @override
  Stream<NewsTopicState> mapEventToState(
    NewsTopicEvent event,
  ) async* {
    if (event is GetTopicsEvent) {
      yield* _mapGetTopicsEventToState(event);
    } else if (event is GetFollowedTopicsEvent) {
      yield* _mapGetFollowedTopicsEventToState(event);
    } else if (event is RefreshTopicsEvent) {
      yield* _mapRefreshTopicsEventToState(event);
    }
  }

  Stream<NewsTopicState> _mapRefreshTopicsEventToState(
      RefreshTopicsEvent event) async* {
    yield NewsTopicRefreshingState();
    try {
      final List<NewsTopicEntity> newsList = await _newsTopicsUseCase
          .call(GetNewsTopicsUseCaseParams(language: event.language));
      if (newsList != null || newsList.isNotEmpty)
        yield NewsTopicLoadSuccessState(newsList.toUIModels);
      else
        yield NewsTopicErrorState(message: 'Unable to refresh data.');
    } catch (e) {
      log('News topics refresh error.', error: e);
      yield NewsTopicErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to Internet.');
    }
  }

  Stream<NewsTopicState> _mapGetTopicsEventToState(
      GetTopicsEvent event) async* {
    if (state is NewsTopicLoadingState) return;
    yield NewsTopicLoadingState();
    try {
      final List<NewsTopicEntity> newsList = await _newsTopicsUseCase
          .call(GetNewsTopicsUseCaseParams(language: event.language));
      if (newsList == null || newsList.isEmpty)
        yield NewsTopicLoadEmptyState(message: 'News topics not available.');
      else
        yield NewsTopicLoadSuccessState(newsList.toUIModels);
    } catch (e) {
      log('News topics load error.', error: e);
      yield NewsTopicLoadErrorState(
          message:
              'Unable to load topics. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsTopicState> _mapGetFollowedTopicsEventToState(
      GetFollowedTopicsEvent event) async* {
    if (state is NewsTopicLoadingState) return;
    yield NewsTopicLoadingState();
    try {
      final List<NewsTopicEntity> topicList = await _newsTopicsUseCase
          .call(GetNewsTopicsUseCaseParams(language: event.language));
      if (topicList == null || topicList.isEmpty)
        yield NewsTopicLoadEmptyState(message: 'News topics not available.');
      else {
        List<NewsTopicEntity> followedTopics =
            topicList.where((e) => e.isFollowed).toList();
        if (followedTopics == null || followedTopics.isEmpty) {
          yield NewsTopicLoadEmptyState(
              message: 'You have not followed any topics yet.');
        } else
          yield NewsTopicLoadSuccessState(followedTopics.toUIModels);
      }
    } catch (e) {
      log('News followed topics load error.', error: e);
      yield NewsTopicLoadErrorState(
          message:
              'Unable to load topics. Make sure you are connect to Internet.');
    }
  }
}
