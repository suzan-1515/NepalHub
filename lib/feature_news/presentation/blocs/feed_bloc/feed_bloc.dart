import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_type.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_latest_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_recent_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_trending_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final UseCase _latestNewsUseCase;
  final UseCase _recentNewsUseCase;
  final UseCase _trendingNewsUseCase;

  FeedBloc(
      {@required UseCase latestNewsUseCase,
      @required UseCase recentNewsUseCase,
      @required UseCase trendingNewsUseCase})
      : _latestNewsUseCase = latestNewsUseCase,
        _recentNewsUseCase = recentNewsUseCase,
        _trendingNewsUseCase = trendingNewsUseCase,
        super(InitialState());

  SortBy _sortBy = SortBy.RECENT;

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is GetNewsEvent) {
      yield* _mapGetNewsEventToState(event);
    } else if (event is RefreshNewsEvent) {
      yield* _mapRefreshNewsEventToState(event);
    } else if (event is LoadMoreNewsEvent) {
      yield* _mapLoadMoreNewsEventToState(event);
    }
  }

  Stream<FeedState> _mapGetNewsEventToState(GetNewsEvent event) async* {
    if (event is LoadingState) return;
    yield LoadingState();
    try {
      List<NewsFeedEntity> newsList;
      switch (event.newsType) {
        case NewsType.TRENDING:
          newsList = await _trendingNewsUseCase.call(
            GetTrendingNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.RECENT:
          newsList = await _recentNewsUseCase.call(
            GetRecentNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.LATEST:
          newsList = await _latestNewsUseCase.call(
            GetLatestNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.LOCAL:
          break;
        case NewsType.BREAKING:
          break;
      }

      if (newsList == null || newsList.isEmpty)
        yield EmptyState(message: 'News feed not available.');
      else
        yield LoadSuccessState(feeds: newsList.toUIModels);
    } catch (e) {
      log('Latest news load error.', error: e);
      yield LoadErrorState(
          message:
              'Unble to load data. Make sure you are connected to internet.');
    }
  }

  Stream<FeedState> _mapRefreshNewsEventToState(RefreshNewsEvent event) async* {
    try {
      List<NewsFeedEntity> newsList;
      switch (event.newsType) {
        case NewsType.TRENDING:
          newsList = await _trendingNewsUseCase.call(
            GetTrendingNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.RECENT:
          newsList = await _recentNewsUseCase.call(
            GetRecentNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.LATEST:
          newsList = await _latestNewsUseCase.call(
            GetLatestNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.LOCAL:
          break;
        case NewsType.BREAKING:
          break;
      }

      if (newsList != null && newsList.isNotEmpty)
        yield LoadSuccessState(feeds: newsList.toUIModels);
    } catch (e) {
      log('News refresh error.', error: e);
      yield ErrorState(
          message:
              'Unble to load data. Make sure you are connected to internet.');
    }
  }

  Stream<FeedState> _mapLoadMoreNewsEventToState(
      LoadMoreNewsEvent event) async* {
    if (event is LoadingMoreState) return;
    final currentState = state;
    yield LoadingMoreState();
    try {
      List<NewsFeedEntity> newsList;
      switch (event.newsType) {
        case NewsType.TRENDING:
          newsList = await _trendingNewsUseCase.call(
            GetTrendingNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.RECENT:
          newsList = await _recentNewsUseCase.call(
            GetRecentNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.LATEST:
          newsList = await _latestNewsUseCase.call(
            GetLatestNewsUseCaseParams(
                sortBy: _sortBy, page: event.page, language: event.langugage),
          );
          break;
        case NewsType.LOCAL:
          break;
        case NewsType.BREAKING:
          break;
      }

      if (newsList == null || newsList.isEmpty) {
        if (currentState is LoadSuccessState) {
          yield currentState.copyWith(hasMore: false);
        } else {
          yield EmptyState(message: 'News feed not available.');
        }
      } else {
        if (currentState is LoadSuccessState) {
          yield currentState.copyWith(
              feeds: currentState.feeds + newsList.toUIModels);
        } else {
          yield LoadSuccessState(feeds: newsList.toUIModels);
        }
      }
    } catch (e) {
      log('News loadmore error.', error: e);
      if (currentState is LoadSuccessState) {
        yield currentState.copyWith(hasMore: false);
        yield ErrorState(message: 'Unable to load more data.');
      } else
        yield LoadErrorState(
            message:
                'Unble to load data. Make sure you are connected to internet.');
    }
  }
}
