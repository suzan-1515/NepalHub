import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_sources_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';

part 'news_sources_event.dart';
part 'news_sources_state.dart';

class NewsSourceBloc extends Bloc<NewsSourcesEvent, NewsSourceState> {
  final UseCase _newsSourcesUseCase;
  final UseCase _newsFollowedSourcesUseCase;

  NewsSourceBloc(
      {@required getNewsSourcesUseCase,
      @required getNewsFollowedSourcesUseCase})
      : _newsSourcesUseCase = getNewsSourcesUseCase,
        _newsFollowedSourcesUseCase = getNewsFollowedSourcesUseCase,
        super(InitialState());

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
    }
  }

  Stream<NewsSourceState> _mapRefreshSourcesEventToState(
      RefreshSourceEvent event) async* {
    try {
      final List<NewsSourceEntity> newsList = await _newsSourcesUseCase
          .call(GetNewsSourcesUseCaseParams(language: event.language));
      if (newsList != null || newsList.isNotEmpty)
        yield LoadSuccessState(newsList.toUIModels);
    } catch (e) {
      log('News sources refresh error.', error: e);
    }
  }

  Stream<NewsSourceState> _mapGetSourcesEventToState(
      GetSourcesEvent event) async* {
    if (state is LoadingState) return;
    yield LoadingState();
    try {
      final List<NewsSourceEntity> newsList = await _newsSourcesUseCase
          .call(GetNewsSourcesUseCaseParams(language: event.language));
      if (newsList == null || newsList.isEmpty)
        yield EmptyState(message: 'News sources not available.');
      else
        yield LoadSuccessState(newsList.toUIModels);
    } catch (e) {
      log('News sources load error.', error: e);
      yield ErrorState(
          message:
              'Unable to load sources. Make sure you are connect to Internet.');
    }
  }

  Stream<NewsSourceState> _mapGetFolloweSourcesEventToState(
      GetFollowedSourcesEvent event) async* {
    if (state is LoadingState) return;
    yield LoadingState();
    try {
      final List<NewsSourceEntity> sourceList = await _newsSourcesUseCase
          .call(GetNewsSourcesUseCaseParams(language: event.language));
      if (sourceList == null || sourceList.isEmpty)
        yield EmptyState(message: 'News sources not available.');
      else {
        final List<NewsSourceEntity> followedSources =
            sourceList.where((element) => element.isFollowed).toList();
        if (followedSources == null || followedSources.isEmpty)
          yield EmptyState(
              message: 'You have not followed any news source yet');
        else
          yield LoadSuccessState(followedSources.toUIModels);
      }
    } catch (e) {
      log('News sources load error.', error: e);
      yield ErrorState(
          message:
              'Unable to load sources. Make sure you are connect to Internet.');
    }
  }
}
