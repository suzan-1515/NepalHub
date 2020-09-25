import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_by_source_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';

part 'news_source_feed_event.dart';
part 'news_source_feed_state.dart';

class NewsSourceFeedBloc
    extends Bloc<NewsSourceFeedEvent, NewsSourceFeedState> {
  final UseCase _newsBySourceUseCase;
  final NewsFilterBloc _newsFilterBloc;

  SortBy _sortBy;
  SortBy get sortBy => _sortBy;

  NewsSourceUIModel _sourceModel;
  NewsSourceUIModel get sourceModel => _sourceModel;

  StreamSubscription _newsFilterBlocSubscription;

  NewsSourceFeedBloc(
      {@required UseCase newsBySourceUseCase,
      @required NewsSourceUIModel sourceModel,
      @required NewsFilterBloc newsFilterBloc})
      : this._newsBySourceUseCase = newsBySourceUseCase,
        this._sourceModel = sourceModel,
        this._newsFilterBloc = newsFilterBloc,
        super(InitialState(sourceModel: sourceModel)) {
    this._newsFilterBlocSubscription = this._newsFilterBloc.listen((state) {
      if (state is InitialState) {
        this._sortBy = _newsFilterBloc.selectedSortBy;
        this._sourceModel = _newsFilterBloc.selectedSource;
      } else if (state is SourceChangedState) {
        this._sourceModel = state.source;
        this.add(RefreshSourceNewsEvent());
      } else if (state is SortByChangedState) {
        this._sortBy = state.sortBy;
        this.add(RefreshSourceNewsEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _newsFilterBlocSubscription.cancel();
    return super.close();
  }

  @override
  Stream<NewsSourceFeedState> mapEventToState(
    NewsSourceFeedEvent event,
  ) async* {
    if (event is GetSourceNewsEvent) {
      yield* _mapGetSourceNewsEventToState(event);
    } else if (event is GetMoreSourceNewsEvent) {
      yield* _mapGetMoreSourceNewsEventToState(event);
    } else if (event is RefreshSourceNewsEvent) {
      yield* _mapRefreshSourceNewsToState(event);
    } else if (event is RetrySourceNewsEvent) {
      yield* _mapRetrySourceNewsToState(event);
    }
  }

  Stream<NewsSourceFeedState> _mapRefreshSourceNewsToState(
      RefreshSourceNewsEvent event) async* {
    final currentState = state;
    if (!(currentState is RefreshingState)) {
      yield RefreshingState();
      try {
        final List<NewsFeedEntity> newsList = await _newsBySourceUseCase.call(
          GetNewsBySourceUseCaseParams(
              source: sourceModel.source,
              sortBy: sortBy,
              page: 1,
              language: event.language),
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
        log('News by source load error.', error: e);
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

  Stream<NewsSourceFeedState> _mapRetrySourceNewsToState(
      RetrySourceNewsEvent event) async* {
    final currentState = state;
    if (currentState is ErrorState) {
      add(GetSourceNewsEvent());
    }
  }

  Stream<NewsSourceFeedState> _mapGetMoreSourceNewsEventToState(
      GetMoreSourceNewsEvent event) async* {
    final currentState = state;
    if (currentState is LoadSuccessState ||
        !(currentState is MoreLoadingState)) {
      yield MoreLoadingState();
      try {
        final List<NewsFeedEntity> newsList = await _newsBySourceUseCase.call(
          GetNewsBySourceUseCaseParams(
              source: sourceModel.source,
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
        log('News by source load more cache error.', error: e);
        yield LoadMoreErrorState(
            message: 'Error loading data from server. Try again later.');
        if (currentState is LoadSuccessState) {
          yield currentState.copyWith(hasMore: false);
        } else
          yield ErrorState(
              message:
                  'Unable to load data. Make sure you are connected to internet.');
      }
    }
  }

  Stream<NewsSourceFeedState> _mapGetSourceNewsEventToState(
      GetSourceNewsEvent event) async* {
    if (state is LoadingState) return;
    yield LoadingState();
    try {
      final List<NewsFeedEntity> newsList = await _newsBySourceUseCase.call(
        GetNewsBySourceUseCaseParams(
          source: sourceModel.source,
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
      log('News by source load error.', error: e);
      yield ErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }
}
