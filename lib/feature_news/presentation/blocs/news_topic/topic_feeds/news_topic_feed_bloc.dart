import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_by_topic_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';

part 'news_topic_feed_event.dart';
part 'news_topic_feed_state.dart';

class NewsTopicFeedBloc extends Bloc<NewsTopicFeedEvent, NewsTopicFeedState> {
  final UseCase _newsByTopicUseCase;
  final NewsFilterBloc _newsFilterBloc;
  final NewsTopicUIModel _topicModel;

  SortBy _sortBy;
  NewsSourceUIModel _source;

  SortBy get sortBy => _sortBy;

  NewsSourceUIModel get sourceModel => _source;

  NewsTopicUIModel get topicModel => _topicModel;
  StreamSubscription _newsFilterBlocSubscription;

  NewsTopicFeedBloc(
      {@required UseCase newsByTopicUseCase,
      @required NewsTopicUIModel topicModel,
      @required NewsFilterBloc newsFilterBloc})
      : this._newsByTopicUseCase = newsByTopicUseCase,
        this._topicModel = topicModel,
        this._newsFilterBloc = newsFilterBloc,
        super(InitialState(topicModel: topicModel)) {
    this._sortBy = _newsFilterBloc.selectedSortBy;
    this._source = _newsFilterBloc.selectedSource;
    this._newsFilterBlocSubscription = this._newsFilterBloc.listen((state) {
      if (state is SourceChangedState) {
        this._source = state.source;
        this.add(RefreshTopicNewsEvent());
      } else if (state is SortByChangedState) {
        this._sortBy = state.sortBy;
        this.add(RefreshTopicNewsEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _newsFilterBlocSubscription.cancel();
    return super.close();
  }

  @override
  Stream<NewsTopicFeedState> mapEventToState(
    NewsTopicFeedEvent event,
  ) async* {
    if (event is GetTopicNewsEvent) {
      yield* _mapGetTopicNewsEventToState(event);
    } else if (event is GetMoreTopicNewsEvent) {
      yield* _mapGetMoreTopicNewsEventToState(event);
    } else if (event is RefreshTopicNewsEvent) {
      yield* _mapRefreshTopicNewsToState(event);
    } else if (event is RetryTopicNewsEvent) {
      yield* _mapRetryTopicNewsToState(event);
    }
  }

  Stream<NewsTopicFeedState> _mapRefreshTopicNewsToState(
      RefreshTopicNewsEvent event) async* {
    final currentState = state;
    if (!(currentState is RefreshingState)) {
      yield RefreshingState();
      try {
        final List<NewsFeedEntity> newsList = await _newsByTopicUseCase.call(
          GetNewsByTopicUseCaseParams(
              topic: topicModel.topic,
              source: sourceModel?.source,
              sortBy: sortBy,
              page: 1),
        );
        if (newsList != null && newsList.isNotEmpty) {
          yield LoadSuccessState(feeds: newsList.toUIModels, hasMore: true);
        } else {
          if (currentState is LoadSuccessState) {
            yield currentState.copyWith(hasMore: false);
          } else
            yield EmptyState(message: 'News feed not available.');
        }
      } catch (e) {
        log('News by topic load error.', error: e);
        if (currentState is LoadSuccessState) {
          yield RefreshErrorState(
              message: 'Unable to load data. Try again later.');
        } else
          yield ErrorState(
              message:
                  'Unable to load data. Make sure you are connected to Internet.');
      }
    }
  }

  Stream<NewsTopicFeedState> _mapRetryTopicNewsToState(
      RetryTopicNewsEvent event) async* {
    final currentState = state;
    if (currentState is ErrorState) {
      add(GetTopicNewsEvent());
    }
  }

  Stream<NewsTopicFeedState> _mapGetMoreTopicNewsEventToState(
      GetMoreTopicNewsEvent event) async* {
    final currentState = state;
    if (currentState is LoadSuccessState ||
        !(currentState is MoreLoadingState)) {
      yield MoreLoadingState();
      try {
        final List<NewsFeedEntity> newsList = await _newsByTopicUseCase.call(
          GetNewsByTopicUseCaseParams(
              topic: topicModel.topic,
              source: sourceModel?.source,
              sortBy: sortBy,
              page: event.page,
              language: event.language),
        );
        if (newsList != null && newsList.isNotEmpty) {
          if (currentState is LoadSuccessState) {
            yield currentState.copyWith(
                feeds: currentState.feeds + newsList.toUIModels);
          } else
            yield LoadSuccessState(feeds: newsList.toUIModels, hasMore: true);
        } else {
          if (currentState is LoadSuccessState) {
            yield currentState.copyWith(hasMore: false);
          } else
            yield EmptyState(message: 'News feed not available.');
        }
      } catch (e) {
        log('News by topic load more cache error.', error: e);
        yield LoadMoreErrorState(
            message: 'Error loading data from server. Try again later.');
        if (currentState is LoadSuccessState) {
          yield currentState.copyWith(hasMore: false);
        } else
          yield ErrorState(
              message:
                  'Unable to load data. Make sure you are connected to Internet.');
      }
    }
  }

  Stream<NewsTopicFeedState> _mapGetTopicNewsEventToState(
      GetTopicNewsEvent event) async* {
    if (state is LoadingState) return;
    yield LoadingState();
    try {
      final List<NewsFeedEntity> newsList = await _newsByTopicUseCase.call(
        GetNewsByTopicUseCaseParams(
          topic: topicModel.topic,
          source: sourceModel?.source,
          sortBy: sortBy,
          page: 1,
          language: event.language,
        ),
      );
      if (newsList == null || newsList.isEmpty)
        yield EmptyState(message: 'News feed not available.');
      else
        yield LoadSuccessState(feeds: newsList.toUIModels, hasMore: true);
    } catch (e) {
      log('News by topic load error.', error: e);
      yield ErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }
}
