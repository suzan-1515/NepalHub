import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_news/domain/usecases/bookmark_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/unbookmark_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';

part 'bookmark_un_bookmark_event.dart';
part 'bookmark_un_bookmark_state.dart';

class BookmarkUnBookmarkBloc
    extends Bloc<BookmarkUnBookmarkEvent, BookmarkUnBookmarkState> {
  final UseCase _addBookmarkNewsUseCase;
  final UseCase _removeBookmarkNewsUseCase;

  BookmarkUnBookmarkBloc(
      {@required UseCase addBookmarkNewsUseCase,
      @required UseCase removeBookmarkNewsUseCase})
      : _addBookmarkNewsUseCase = addBookmarkNewsUseCase,
        _removeBookmarkNewsUseCase = removeBookmarkNewsUseCase,
        assert(addBookmarkNewsUseCase != null),
        assert(removeBookmarkNewsUseCase != null),
        super(BookmarkUnBookmarkInitial());

  @override
  Stream<BookmarkUnBookmarkState> mapEventToState(
    BookmarkUnBookmarkEvent event,
  ) async* {
    if (state is BookmarkInProgress) return;
    if (event is BookmarkNews) {
      yield BookmarkInProgress();
      try {
        await _addBookmarkNewsUseCase.call(
          BookmarkNewsUseCaseParams(
            feed: event.feedModel.feed,
          ),
        );
        yield BookmarkSuccess(message: 'News bookmarked successfully.');
      } catch (e) {
        log('Bookmark news error.', error: e);
        yield BookmarkUnBookmarkError(message: 'Unable to bookmark.');
      }
    } else if (event is UnBookmarkNews) {
      yield BookmarkInProgress();
      try {
        await _removeBookmarkNewsUseCase.call(
          UnBookmarkNewsUseCaseParams(
            feed: event.feedModel.feed,
          ),
        );
        yield UnbookmarkSuccess(message: 'News unbookmark successfully.');
      } catch (e) {
        log('Unbookmark news error.', error: e);
        yield BookmarkUnBookmarkError(message: 'Unable to unbookmark.');
      }
    }
  }
}
