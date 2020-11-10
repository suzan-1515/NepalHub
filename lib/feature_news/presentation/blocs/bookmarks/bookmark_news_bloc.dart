import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_bookmarked_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'bookmark_news_event.dart';
part 'bookmark_news_state.dart';

class BookmarkNewsBloc extends Bloc<BookmarkNewsEvent, BookmarkNewsState> {
  final UseCase _getBookmarkNewsUseCase;

  BookmarkNewsBloc({@required UseCase getBookmarkNewsUseCase})
      : this._getBookmarkNewsUseCase = getBookmarkNewsUseCase,
        super(BookmarkNewsInitialState());

  int _page = 0;
  int get page => _page;

  @override
  Stream<BookmarkNewsState> mapEventToState(
    BookmarkNewsEvent event,
  ) async* {
    if (event is GetBookmarkedNews) {
      yield* _mapGetBookmarkedNewsEventToState(event);
    } else if (event is RefreshBookmarkedNewsEvent) {
      yield* _mapRefreshBookmarkedNewsEventToState(event);
    } else if (event is LoadMoreBookmarkedNewsEvent) {
      yield* _mapLoadMoreBookmarkedNewsEventToState(event);
    }
  }

  Stream<BookmarkNewsState> _mapGetBookmarkedNewsEventToState(
      GetBookmarkedNews event) async* {
    if (state is BookmarkNewsLoadingState) return;
    yield BookmarkNewsLoadingState();
    try {
      _page = 1;
      final List<NewsFeedEntity> newsList = await _getBookmarkNewsUseCase.call(
        GetBookmarkedNewsUseCaseParams(
          page: page,
        ),
      );
      if (newsList == null || newsList.isEmpty)
        yield BookmarkNewsEmptyState(
            message: 'You have not bookmarked any news yet.');
      else
        yield BookmarkNewsLoadSuccessState(newsList.toUIModels);
    } catch (e) {
      log('Bookmark news load error.', error: e);
      yield BookmarkNewsLoadErrorState(
          message:
              'Unable to load data. Make sure you are connected to internet.');
    }
  }

  Stream<BookmarkNewsState> _mapRefreshBookmarkedNewsEventToState(
      RefreshBookmarkedNewsEvent event) async* {
    try {
      final List<NewsFeedEntity> newsList = await _getBookmarkNewsUseCase.call(
        GetBookmarkedNewsUseCaseParams(
          page: 1,
        ),
      );
      if (newsList != null || newsList.isNotEmpty) {
        _page = 1;
        yield BookmarkNewsLoadSuccessState(newsList.toUIModels);
      } else
        yield BookmarkNewsErrorState(message: 'Unable to refresh.');
    } catch (e) {
      log('Refresh bookmark news load error.', error: e);
      yield BookmarkNewsErrorState(
          message:
              'Unable to refresh data. Make sure you are connected to internet.');
    }
  }

  Stream<BookmarkNewsState> _mapLoadMoreBookmarkedNewsEventToState(
      LoadMoreBookmarkedNewsEvent event) async* {
    if (state is BookmarkNewsLoadingState) return;
    final currentState = state;
    try {
      final List<NewsFeedEntity> newsList = await _getBookmarkNewsUseCase.call(
        GetBookmarkedNewsUseCaseParams(
          page: page + 1,
        ),
      );

      if (newsList == null || newsList.isEmpty) {
        if (currentState is BookmarkNewsLoadSuccessState) {
          yield currentState.copyWith(hasMore: false);
        } else {
          _page = 1;
          yield BookmarkNewsEmptyState(
              message: 'You have not bookmarked any news yet.');
        }
      } else {
        _page = _page + 1;
        if (currentState is BookmarkNewsLoadSuccessState) {
          yield currentState.copyWith(
              feeds: currentState.feeds + newsList.toUIModels);
        } else
          yield BookmarkNewsLoadSuccessState(newsList.toUIModels);
      }
    } catch (e) {
      log('Load more bookmark news error.', error: e);
      yield BookmarkNewsErrorState(
          message:
              'Unable to load more data. Make sure you are connected to internet.');
    }
  }
}
