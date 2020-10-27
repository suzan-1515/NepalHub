import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
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
  int _page = 1;

  NewsSourceUIModel _sourceModel;
  NewsSourceUIModel get sourceModel => _sourceModel;
  int get page => _page;

  StreamSubscription _newsFilterBlocSubscription;

  NewsSourceFeedBloc(
      {@required UseCase newsBySourceUseCase,
      @required NewsSourceUIModel sourceModel,
      @required NewsFilterBloc newsFilterBloc})
      : this._newsBySourceUseCase = newsBySourceUseCase,
        this._sourceModel = sourceModel,
        this._newsFilterBloc = newsFilterBloc,
        super(NewsSourceFeedInitialState(sourceModel: sourceModel)) {
    this._sortBy = _newsFilterBloc.selectedSortBy;
    this._newsFilterBlocSubscription = this._newsFilterBloc.listen((state) {
      if (state is SourceChangedState) {
        if (state.source != null) this._sourceModel = state.source;
        this.add(GetSourceNewsEvent());
      } else if (state is SortByChangedState) {
        this._sortBy = state.sortBy;
        this.add(GetSourceNewsEvent());
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
    }
  }

  Stream<NewsSourceFeedState> _mapRefreshSourceNewsToState(
      RefreshSourceNewsEvent event) async* {
    if (state is NewsSourceFeedLoadingState) return;
    try {
      final List<NewsFeedEntity> newsList = await _newsBySourceUseCase.call(
        GetNewsBySourceUseCaseParams(
            source: sourceModel.source,
            sortBy: sortBy,
            page: 1,
            language: event.language),
      );
      if (newsList != null && newsList.isNotEmpty) {
        yield NewsSourceFeedLoadSuccessState(
            feeds: newsList.toUIModels, hasMore: true);
      } else {
        yield NewsSourceFeedErrorState(message: 'Unable to refresh.');
      }
    } catch (e) {
      log('News by source refresh error.', error: e);
      yield NewsSourceFeedErrorState(
          message:
              'Unable to load data. Make sure you are connected to Internet.');
    }
  }

  Stream<NewsSourceFeedState> _mapGetMoreSourceNewsEventToState(
      GetMoreSourceNewsEvent event) async* {
    final currentState = state;
    if (currentState is NewsSourceFeedLoadSuccessState) return;
    yield NewsSourceFeedMoreLoadingState();
    try {
      final List<NewsFeedEntity> newsList = await _newsBySourceUseCase.call(
        GetNewsBySourceUseCaseParams(
            source: sourceModel.source,
            sortBy: sortBy,
            page: page + 1,
            language: event.language),
      );
      if (newsList != null && newsList.isNotEmpty) {
        _page = _page + 1;
        if (currentState is NewsSourceFeedLoadSuccessState) {
          yield currentState.copyWith(
              feeds: currentState.feeds + newsList.toUIModels);
        } else
          yield NewsSourceFeedLoadSuccessState(
              feeds: newsList.toUIModels, hasMore: true);
      } else {
        if (currentState is NewsSourceFeedLoadSuccessState) {
          yield currentState.copyWith(hasMore: false);
        }
      }
    } catch (e) {
      log('News by source load more cache error.', error: e);
      yield NewsSourceFeedErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }

  Stream<NewsSourceFeedState> _mapGetSourceNewsEventToState(
      GetSourceNewsEvent event) async* {
    if (state is NewsSourceFeedLoadingState) return;
    yield NewsSourceFeedLoadingState();
    try {
      _page = 1;
      final List<NewsFeedEntity> newsList = await _newsBySourceUseCase.call(
        GetNewsBySourceUseCaseParams(
          source: sourceModel.source,
          sortBy: sortBy,
          page: page,
          language: event.language,
        ),
      );
      if (newsList == null || newsList.isEmpty)
        yield NewsSourceFeedEmptyState(message: 'News feed not available.');
      else
        yield NewsSourceFeedLoadSuccessState(
            feeds: newsList.toUIModels, hasMore: true);
    } catch (e) {
      log('News by source load error.', error: e);
      yield NewsSourceFeedLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }
}
