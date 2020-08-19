// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookmarkStore on _BookmarkStore, Store {
  final _$errorAtom = Atom(name: '_BookmarkStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadInitialDataAsyncAction =
      AsyncAction('_BookmarkStore.loadInitialData');

  @override
  Future<void> loadInitialData() {
    return _$loadInitialDataAsyncAction.run(() => super.loadInitialData());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('_BookmarkStore.loadMoreData');

  @override
  Future<void> loadMoreData({String after}) {
    return _$loadMoreDataAsyncAction
        .run(() => super.loadMoreData(after: after));
  }

  final _$addBookmarkedFeedAsyncAction =
      AsyncAction('_BookmarkStore.addBookmarkedFeed');

  @override
  Future<bool> addBookmarkedFeed({@required NewsFeed feed}) {
    return _$addBookmarkedFeedAsyncAction
        .run(() => super.addBookmarkedFeed(feed: feed));
  }

  final _$removeBookmarkedFeedAsyncAction =
      AsyncAction('_BookmarkStore.removeBookmarkedFeed');

  @override
  Future<bool> removeBookmarkedFeed({@required NewsFeed feed}) {
    return _$removeBookmarkedFeedAsyncAction
        .run(() => super.removeBookmarkedFeed(feed: feed));
  }

  final _$isBookmarkedFeedAsyncAction =
      AsyncAction('_BookmarkStore.isBookmarkedFeed');

  @override
  Future<bool> isBookmarkedFeed({@required NewsFeed feed}) {
    return _$isBookmarkedFeedAsyncAction
        .run(() => super.isBookmarkedFeed(feed: feed));
  }

  final _$refreshAsyncAction = AsyncAction('_BookmarkStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_BookmarkStoreActionController =
      ActionController(name: '_BookmarkStore');

  @override
  Future<dynamic> _loadFirstPageData() {
    final _$actionInfo = _$_BookmarkStoreActionController.startAction(
        name: '_BookmarkStore._loadFirstPageData');
    try {
      return super._loadFirstPageData();
    } finally {
      _$_BookmarkStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_BookmarkStoreActionController.startAction(
        name: '_BookmarkStore.retry');
    try {
      return super.retry();
    } finally {
      _$_BookmarkStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error}
    ''';
  }
}
