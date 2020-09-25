import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_news_by_category_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_filter/news_filter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';

part 'news_category_feed_event.dart';
part 'news_category_feed_state.dart';

class NewsCategoryFeedBloc
    extends Bloc<NewsCategoryFeedEvent, NewsCategoryFeedState> {
  final UseCase _newsByCategoryUseCase;
  final NewsFilterBloc _newsFilterBloc;
  final NewsCategoryUIModel _categoryModel;

  SortBy _sortBy;
  NewsSourceUIModel _source;

  SortBy get sortBy => _sortBy;
  NewsSourceUIModel get sourceModel => _source;
  NewsCategoryUIModel get categoryModel => _categoryModel;

  StreamSubscription _newsFilterBlocSubscription;

  NewsCategoryFeedBloc(
      {@required UseCase newsByCategoryUseCase,
      @required NewsCategoryUIModel categoryModel,
      @required NewsFilterBloc newsFilterBloc})
      : this._newsByCategoryUseCase = newsByCategoryUseCase,
        this._categoryModel = categoryModel,
        this._newsFilterBloc = newsFilterBloc,
        super(Initial(categoryModel: categoryModel)) {
    this._newsFilterBlocSubscription = this._newsFilterBloc.listen((state) {
      if (state is InitialState) {
        this._sortBy = _newsFilterBloc.selectedSortBy;
        this._source = _newsFilterBloc.selectedSource;
      } else if (state is SourceChangedState) {
        this._source = state.source;
        this.add(RefreshCategoryNewsEvent());
      } else if (state is SortByChangedState) {
        this._sortBy = state.sortBy;
        this.add(RefreshCategoryNewsEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _newsFilterBlocSubscription.cancel();
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
    } else if (event is RetryCategoryNewsEvent) {
      yield* _mapRetryCategoryNewsToState(event);
    }
  }

  Stream<NewsCategoryFeedState> _mapRefreshCategoryNewsToState(
      RefreshCategoryNewsEvent event) async* {
    final currentState = state;
    if (!(currentState is Refreshing)) {
      yield Refreshing();
      try {
        final List<NewsFeedEntity> newsList = await _newsByCategoryUseCase.call(
          GetNewsByCategoryUseCaseParams(
              category: categoryModel.category,
              sortBy: sortBy,
              page: 1,
              language: event.language),
        );
        if (newsList != null && newsList.isNotEmpty) {
          yield LoadSuccess(feeds: newsList.toUIModels, hasMore: true);
        } else {
          if (currentState is LoadSuccess) {
            yield currentState.copyWith(hasMore: false);
          } else
            yield Empty(message: 'News feed not available.');
        }
      } catch (e) {
        log('News by category load error.', error: e);
        if (currentState is LoadSuccess) {
          yield RefreshError(message: 'Unable to load data. Try again later.');
        } else
          yield ErrorState(
              message:
                  'Unable to load data. Make sure you are connected to Internet.');
      }
    }
  }

  Stream<NewsCategoryFeedState> _mapRetryCategoryNewsToState(
      RetryCategoryNewsEvent event) async* {
    final currentState = state;
    if (currentState is ErrorState) {
      add(GetCategoryNewsEvent());
    }
  }

  Stream<NewsCategoryFeedState> _mapGetMoreCategoryNewsEventToState(
      GetMoreCategoryNewsEvent event) async* {
    final currentState = state;
    if (currentState is LoadSuccess || !(currentState is LoadMoreLoading)) {
      yield LoadMoreLoading();
      try {
        final List<NewsFeedEntity> newsList = await _newsByCategoryUseCase.call(
          GetNewsByCategoryUseCaseParams(
              category: categoryModel.category,
              sortBy: sortBy,
              page: event.page,
              language: event.language),
        );
        if (newsList != null && newsList.isNotEmpty) {
          if (currentState is LoadSuccess) {
            yield currentState.copyWith(
                feeds: currentState.feeds + newsList.toUIModels);
          } else
            yield LoadSuccess(feeds: newsList.toUIModels, hasMore: true);
        } else {
          if (currentState is LoadSuccess) {
            yield currentState.copyWith(hasMore: false);
          } else
            yield Empty(message: 'News feed not available.');
        }
      } catch (e) {
        log('News by category load more cache error.', error: e);
        yield LoadMoreError(
            message: 'Error loading data from server. Try again later.');
        if (currentState is LoadSuccess) {
          yield currentState.copyWith(hasMore: false);
        } else
          yield ErrorState(
              message:
                  'Unable to load data. Make sure you are connected to internet.');
      }
    }
  }

  Stream<NewsCategoryFeedState> _mapGetCategoryNewsEventToState(
      GetCategoryNewsEvent event) async* {
    if (state is Loading) return;
    yield Loading();
    try {
      final List<NewsFeedEntity> newsList = await _newsByCategoryUseCase.call(
        GetNewsByCategoryUseCaseParams(
          category: categoryModel.category,
          sortBy: sortBy,
          page: 1,
          language: event.language,
        ),
      );
      if (newsList == null || newsList.isEmpty)
        yield Empty(message: 'News feed not available.');
      else
        yield LoadSuccess(feeds: newsList.toUIModels, hasMore: true);
    } catch (e) {
      log('News by category load error.', error: e);
      yield ErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }
}
