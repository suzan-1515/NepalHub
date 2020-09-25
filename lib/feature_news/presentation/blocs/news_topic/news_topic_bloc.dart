import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_topics_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

part 'news_topic_event.dart';
part 'news_topic_state.dart';

class NewsTopicBloc extends Bloc<NewsTopicEvent, NewsTopicState> {
  final UseCase _newsTopicsUseCase;
  final UseCase _newsFollowedTopicsUseCase;

  NewsTopicBloc(
      {@required getNewsTopicsUseCase, @required getNewsFollowedTopicsUseCase})
      : _newsTopicsUseCase = getNewsTopicsUseCase,
        _newsFollowedTopicsUseCase = getNewsFollowedTopicsUseCase,
        super(LoadingState());

  @override
  Stream<NewsTopicState> mapEventToState(
    NewsTopicEvent event,
  ) async* {
    if (state is LoadingState) return;
    if (event is GetTopicsEvent) {
      yield LoadingState();
      try {
        final List<NewsTopicEntity> topicList = await _newsTopicsUseCase
            .call(GetNewsTopicsUseCaseParams(language: event.language));
        if (topicList == null || topicList.isEmpty)
          yield EmptyState(message: 'News topics not available.');
        else
          yield LoadSuccessState(topicList.toUIModels);
      } catch (e) {
        log('News topics load cache error.', error: e);
        yield ErrorState(
            message:
                'Unable to load data. Make sure you have internet connection.');
      }
    } else if (event is GetFollowedTopicsEvent) {
      yield LoadingState();
      try {
        final List<NewsTopicEntity> topicList = await _newsTopicsUseCase
            .call(GetNewsTopicsUseCaseParams(language: event.language));
        if (topicList == null || topicList.isEmpty)
          yield EmptyState(message: 'News topics not available.');
        else {
          final List<NewsTopicEntity> followedTopics =
              topicList.where((element) => element.isFollowed).toList();
          if (followedTopics == null || followedTopics.isEmpty)
            yield EmptyState(
                message: 'You have not followed any news topic yet.');
          else
            yield LoadSuccessState(followedTopics.toUIModels);
        }
      } catch (e) {
        log('News topics load cache error.', error: e);
        yield ErrorState(
            message:
                'Unable to load data. Make sure you have internet connection.');
      }
    }
  }
}
