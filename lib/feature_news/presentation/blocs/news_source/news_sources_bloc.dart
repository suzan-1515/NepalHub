import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_sources_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';

part 'news_sources_event.dart';
part 'news_sources_state.dart';

class NewsSourceBloc extends Bloc<NewsSourcesEvent, NewsSourceState> {
  final UseCase _newsSourcesUseCase;
  final UseCase _newsFollowedSourcesUseCase;

  NewsSourceBloc({
    @required UseCase getNewsSourcesUseCase,
    @required UseCase getNewsFollowedSourcesUseCase,
  })  : _newsSourcesUseCase = getNewsSourcesUseCase,
        _newsFollowedSourcesUseCase = getNewsFollowedSourcesUseCase,
        super(NewsSourceInitialState());

  @override
  Stream<NewsSourceState> mapEventToState(
    NewsSourcesEvent event,
  ) async* {
    if (event is GetSourcesEvent) {
      yield* _mapGetSourcesEventToState(event);
    } else if (event is GetFollowedSourcesEvent) {
      yield* _mapGetFolloweSourcesEventToState(event);
    } else if (event is RefreshSourceEvent) {
      yield* _mapRefreshSourcesEventToState(event);
    } else if (event is UpdateSourceChangeEvent) {
      yield* _mapUpdateFollowEventToState(event);
    }
  }

  Stream<NewsSourceState> _mapRefreshSourcesEventToState(
      RefreshSourceEvent event) async* {
    yield NewsSourceRefreshingState();
    try {
      final List<NewsSourceEntity> newsList = await _newsSourcesUseCase
          .call(GetNewsSourcesUseCaseParams(language: event.language));
      if (newsList != null || newsList.isNotEmpty)
        yield NewsSourceLoadSuccessState(newsList.toUIModels);
      else
        yield NewsSourceErrorState(message: 'Unable to refresh data.');
    } catch (e) {
      log('News sources refresh error.', error: e);
      yield NewsSourceErrorState(
          message:
              'Unable to refresh data. Make sure yoy are connected to Internet.');
    }
  }

  Stream<NewsSourceState> _mapGetSourcesEventToState(
      GetSourcesEvent event) async* {
    if (state is NewsSourceLoadingState) return;
    yield NewsSourceLoadingState();
    try {
      final List<NewsSourceEntity> newsList = await _newsSourcesUseCase
          .call(GetNewsSourcesUseCaseParams(language: event.language));
      if (newsList == null || newsList.isEmpty)
        yield NewsSourceLoadEmptyState(message: 'News sources not available.');
      else
        yield NewsSourceLoadSuccessState(newsList.toUIModels);
    } catch (e) {
      log('News sources load error.', error: e);
      yield NewsSourceLoadErrorState(
          message:
              'Unable to load sources. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsSourceState> _mapGetFolloweSourcesEventToState(
      GetFollowedSourcesEvent event) async* {
    if (state is NewsSourceLoadingState) return;
    yield NewsSourceLoadingState();
    try {
      final List<NewsSourceEntity> sourceList = await _newsSourcesUseCase
          .call(GetNewsSourcesUseCaseParams(language: event.language));
      if (sourceList == null || sourceList.isEmpty)
        yield NewsSourceLoadEmptyState(message: 'News sources not available.');
      else {
        final List<NewsSourceEntity> followedSources =
            sourceList.where((element) => element.isFollowed).toList();
        if (followedSources == null || followedSources.isEmpty)
          yield NewsSourceLoadEmptyState(
              message: 'You have not followed any news source yet');
        else
          yield NewsSourceLoadSuccessState(followedSources.toUIModels);
      }
    } catch (e) {
      log('News sources load error.', error: e);
      yield NewsSourceLoadErrorState(
          message:
              'Unable to load sources. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsSourceState> _mapUpdateFollowEventToState(
      UpdateSourceChangeEvent event) async* {
    try {
      final currentState = state;
      if (currentState is NewsSourceLoadSuccessState) {
        final index = currentState.sources
            .indexWhere((element) => element.entity.id == event.source.id);
        if (index != -1) {
          var sources = List<NewsSourceUIModel>.from(currentState.sources);
          sources[index].entity = event.source;
          yield NewsSourceLoadSuccessState(sources);
        }
      }
    } catch (e) {
      log('Update source ${event.eventType} event error: ', error: e);
    }
  }
}
