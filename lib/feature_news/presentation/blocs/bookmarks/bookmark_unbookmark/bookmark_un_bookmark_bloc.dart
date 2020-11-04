import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/domain/usecases/bookmark_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unbookmark_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';

part 'bookmark_un_bookmark_event.dart';
part 'bookmark_un_bookmark_state.dart';

class BookmarkUnBookmarkBloc
    extends Bloc<BookmarkUnBookmarkEvent, BookmarkUnBookmarkState> {
  final UseCase _addBookmarkNewsUseCase;
  final UseCase _removeBookmarkNewsUseCase;

  StreamSubscription _feedEventStreamSubscription;

  BookmarkUnBookmarkBloc({
    @required UseCase addBookmarkNewsUseCase,
    @required UseCase removeBookmarkNewsUseCase,
  })  : _addBookmarkNewsUseCase = addBookmarkNewsUseCase,
        _removeBookmarkNewsUseCase = removeBookmarkNewsUseCase,
        assert(addBookmarkNewsUseCase != null),
        assert(removeBookmarkNewsUseCase != null),
        super(BookmarkUnBookmarkInitial()) {
    this._feedEventStreamSubscription =
        GetIt.I.get<EventBus>().on<NewsChangeEvent>().listen((event) {
      switch (event.eventType) {
        case 'bookmark':
          add(UpdateBookmarkEvent(feed: event.data));
          break;
        case 'unbookmark':
          add(UpdateUnbookmarkEvent(feed: event.data));
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _feedEventStreamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<Transition<BookmarkUnBookmarkEvent, BookmarkUnBookmarkState>>
      transformEvents(Stream<BookmarkUnBookmarkEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<BookmarkUnBookmarkState> mapEventToState(
    BookmarkUnBookmarkEvent event,
  ) async* {
    if (event is BookmarkNews) {
      yield* _mapBookmarkEventToState(event);
    } else if (event is UnBookmarkNews) {
      yield* _mapUnBookmarkEventToState(event);
    } else if (event is UpdateBookmarkEvent) {
      yield* _mapUpdateBookmarkEventToState(event);
    } else if (event is UpdateUnbookmarkEvent) {
      yield* _mapUpdateUnBookmarkEventToState(event);
    }
  }

  Stream<BookmarkUnBookmarkState> _mapBookmarkEventToState(
    BookmarkNews event,
  ) async* {
    if (state is BookmarkInProgress) return;
    yield BookmarkInProgress();
    try {
      final NewsFeedEntity newsFeedEntity =
          await _addBookmarkNewsUseCase.call(BookmarkNewsUseCaseParams(
        feed: event.feed,
      ));
      if (newsFeedEntity != null)
        yield BookmarkSuccess(feed: newsFeedEntity);
      else
        yield BookmarkUnBookmarkError(message: 'Unable to bookmark.');
    } catch (e) {
      log('Bookmark news error.', error: e);
      yield BookmarkUnBookmarkError(message: 'Unable to bookmark.');
    }
  }

  Stream<BookmarkUnBookmarkState> _mapUnBookmarkEventToState(
    UnBookmarkNews event,
  ) async* {
    if (state is BookmarkInProgress) return;
    yield BookmarkInProgress();
    try {
      final NewsFeedEntity newsFeedEntity =
          await _removeBookmarkNewsUseCase.call(UnBookmarkNewsUseCaseParams(
        feed: event.feed,
      ));
      if (newsFeedEntity != null)
        yield UnbookmarkSuccess(feed: newsFeedEntity);
      else
        yield BookmarkUnBookmarkError(message: 'Unable to bookmark.');
    } catch (e) {
      log('UnBookmark news error.', error: e);
      yield BookmarkUnBookmarkError(message: 'Unable to bookmark.');
    }
  }

  Stream<BookmarkUnBookmarkState> _mapUpdateBookmarkEventToState(
    UpdateBookmarkEvent event,
  ) async* {
    try {
      if (event.feed.isBookmarked) return;
      final feed = event.feed.copyWith(
          isBookmarked: true, bookmarkCount: event.feed.bookmarkCount + 1);
      yield BookmarkSuccess(feed: feed);
    } catch (e) {
      log('Update news bookmark error: ', error: e);
    }
  }

  Stream<BookmarkUnBookmarkState> _mapUpdateUnBookmarkEventToState(
    UpdateUnbookmarkEvent event,
  ) async* {
    try {
      if (!event.feed.isBookmarked) return;
      final feed = event.feed.copyWith(
          isBookmarked: false, bookmarkCount: event.feed.bookmarkCount - 1);
      yield UnbookmarkSuccess(feed: feed);
    } catch (e) {
      log('Update news unbookmark error: ', error: e);
    }
  }
}
