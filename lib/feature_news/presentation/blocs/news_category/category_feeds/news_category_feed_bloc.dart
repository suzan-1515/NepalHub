import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/sort.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_by_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'news_category_feed_event.dart';
part 'news_category_feed_state.dart';

class NewsCategoryFeedBloc
    extends Bloc<NewsCategoryFeedEvent, NewsCategoryFeedState> {
  final UseCase _newsByCategoryUseCase;
  final NewsFilterBloc _newsFilterBloc;
  final NewsCategoryUIModel _categoryEntity;

  SortBy _sortBy;
  NewsSourceEntity _source;
  int _page = 1;

  SortBy get sortBy => _sortBy;
  NewsSourceEntity get source => _source;
  NewsCategoryUIModel get category => _categoryEntity;
  int get page => _page;

  StreamSubscription _newsFilterBlocSubscription;

  NewsCategoryFeedBloc(
      {@required UseCase newsByCategoryUseCase,
      @required NewsCategoryUIModel category,
      @required NewsFilterBloc newsFilterBloc})
      : this._newsByCategoryUseCase = newsByCategoryUseCase,
        this._categoryEntity = category,
        this._newsFilterBloc = newsFilterBloc,
        super(NewsCategoryFeedInitialState(category: category)) {
    this._newsFilterBlocSubscription = this._newsFilterBloc.listen((state) {
      this._sortBy = _newsFilterBloc.selectedSortBy;
      this._source = _newsFilterBloc.selectedSource;
      if (state is SourceChangedState) {
        this._source = state.source;
        this.add(GetCategoryNewsEvent());
      } else if (state is SortByChangedState) {
        this._sortBy = state.sortBy;
        this.add(GetCategoryNewsEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _newsFilterBlocSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<NewsCategoryFeedState> mapEventToState(
    NewsCategoryFeedEvent event,
  ) async* {
    if (event is GetCategoryNewsEvent) {
      yield* _mapGetCategoryNewsEventToState(event);
    } else if (event is GetMoreCategoryNewsEvent) {
      yield* _mapGetMoreCategoryNewsEventToState(event);
    } else if (event is RefreshCategoryNewsEvent) {
      yield* _mapRefreshCategoryNewsToState(event);
    }
  }

  Stream<NewsCategoryFeedState> _mapRefreshCategoryNewsToState(
      RefreshCategoryNewsEvent event) async* {
    if (state is NewsCategoryFeedLoadingState) return;
    try {
      final List<NewsFeedEntity> newsList = await _newsByCategoryUseCase.call(
        GetNewsByCategoryUseCaseParams(
            category: category.entity,
            source: source,
            sortBy: sortBy,
            page: 1,
            language: event.language),
      );
      if (newsList != null && newsList.isNotEmpty) {
        _page = 1;
        yield NewsCategoryFeedLoadSuccessState(
            feeds: newsList.toUIModels, hasMore: true);
      } else {
        yield NewsCategoryFeedErrorState(message: 'Unable to refresh');
      }
    } catch (e) {
      log('News by category refresh error.', error: e);
      yield NewsCategoryFeedErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to Internet.');
    }
  }

  Stream<NewsCategoryFeedState> _mapGetMoreCategoryNewsEventToState(
      GetMoreCategoryNewsEvent event) async* {
    final currentState = state;
    if (currentState is NewsCategoryFeedMoreLoadingState) return;
    yield NewsCategoryFeedMoreLoadingState();
    try {
      final List<NewsFeedEntity> newsList = await _newsByCategoryUseCase.call(
        GetNewsByCategoryUseCaseParams(
            category: category.entity,
            source: source,
            sortBy: sortBy,
            page: page + 1,
            language: event.language),
      );
      if (newsList == null || newsList.isEmpty) {
        if (currentState is NewsCategoryFeedLoadSuccessState) {
          yield currentState.copyWith(hasMore: false);
        } else
          yield NewsCategoryFeedEmptyState(message: 'News feed not available.');
      } else {
        _page = _page + 1;
        if (currentState is NewsCategoryFeedLoadSuccessState) {
          yield currentState.copyWith(
              feeds: currentState.feeds + newsList.toUIModels);
        } else
          yield NewsCategoryFeedLoadSuccessState(
              feeds: newsList.toUIModels, hasMore: true);
      }
    } catch (e) {
      log('News by category load more cache error.', error: e);
      if (currentState is NewsCategoryFeedLoadSuccessState) {
        yield currentState.copyWith(hasMore: false);
      } else
        yield NewsCategoryFeedErrorState(
            message:
                'Unable to load more data. Make sure you are connected to internet.');
    }
  }

  Stream<NewsCategoryFeedState> _mapGetCategoryNewsEventToState(
      GetCategoryNewsEvent event) async* {
    if (state is NewsCategoryFeedLoadingState) return;
    yield NewsCategoryFeedLoadingState();
    try {
      _page = 1;
      final List<NewsFeedEntity> newsList = await _newsByCategoryUseCase.call(
        GetNewsByCategoryUseCaseParams(
          category: category.entity,
          source: source,
          sortBy: sortBy,
          page: page,
          language: event.language,
        ),
      );
      if (newsList == null || newsList.isEmpty)
        yield NewsCategoryFeedEmptyState(message: 'News feed not available.');
      else
        yield NewsCategoryFeedLoadSuccessState(
            feeds: newsList.toUIModels, hasMore: true);
    } catch (e) {
      log('News by category load error.', error: e);
      yield NewsCategoryFeedLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }
}
