// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookmarkStore on _BookmarkStore, Store {
  final _$errorAtom = Atom(name: '_BookmarkStore.error');

  @override
  String get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$loadInitialDataAsyncAction = AsyncAction('loadInitialData');

  @override
  Future<void> loadInitialData() {
    return _$loadInitialDataAsyncAction.run(() => super.loadInitialData());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('loadMoreData');

  @override
  Future<void> loadMoreData({dynamic resetPage = false}) {
    return _$loadMoreDataAsyncAction
        .run(() => super.loadMoreData(resetPage: resetPage));
  }

  final _$toggleBookmarkAsyncAction = AsyncAction('toggleBookmark');

  @override
  Future<bool> toggleBookmark({@required Feed feed}) {
    return _$toggleBookmarkAsyncAction
        .run(() => super.toggleBookmark(feed: feed));
  }

  final _$addBookmarkedFeedAsyncAction = AsyncAction('addBookmarkedFeed');

  @override
  Future<bool> addBookmarkedFeed({@required Feed feed}) {
    return _$addBookmarkedFeedAsyncAction
        .run(() => super.addBookmarkedFeed(feed: feed));
  }

  final _$removeBookmarkedFeedAsyncAction = AsyncAction('removeBookmarkedFeed');

  @override
  Future<bool> removeBookmarkedFeed({@required Feed feed}) {
    return _$removeBookmarkedFeedAsyncAction
        .run(() => super.removeBookmarkedFeed(feed: feed));
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_BookmarkStoreActionController =
      ActionController(name: '_BookmarkStore');

  @override
  void retry() {
    final _$actionInfo = _$_BookmarkStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_BookmarkStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'error: ${error.toString()}';
    return '{$string}';
  }
}
