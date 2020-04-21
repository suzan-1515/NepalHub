// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavouritesStore on _FavouritesStore, Store {
  final _$loadFeedItemsFutureAtom =
      Atom(name: '_FavouritesStore.loadFeedItemsFuture');

  @override
  ObservableFuture<dynamic> get loadFeedItemsFuture {
    _$loadFeedItemsFutureAtom.context
        .enforceReadPolicy(_$loadFeedItemsFutureAtom);
    _$loadFeedItemsFutureAtom.reportObserved();
    return super.loadFeedItemsFuture;
  }

  @override
  set loadFeedItemsFuture(ObservableFuture<dynamic> value) {
    _$loadFeedItemsFutureAtom.context.conditionallyRunInAction(() {
      super.loadFeedItemsFuture = value;
      _$loadFeedItemsFutureAtom.reportChanged();
    }, _$loadFeedItemsFutureAtom,
        name: '${_$loadFeedItemsFutureAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_FavouritesStore.error');

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

  final _$_loadFirstPageFeedsAsyncAction = AsyncAction('_loadFirstPageFeeds');

  @override
  Future<dynamic> _loadFirstPageFeeds() {
    return _$_loadFirstPageFeedsAsyncAction
        .run(() => super._loadFirstPageFeeds());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('loadMoreData');

  @override
  Future<void> loadMoreData() {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData());
  }

  final _$addFavouriteFeedAsyncAction = AsyncAction('addFavouriteFeed');

  @override
  Future<bool> addFavouriteFeed({@required Feed feed}) {
    return _$addFavouriteFeedAsyncAction
        .run(() => super.addFavouriteFeed(feed: feed));
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_FavouritesStoreActionController =
      ActionController(name: '_FavouritesStore');

  @override
  void loadInitialFeeds() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.loadInitialFeeds();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadFeedItemsFuture: ${loadFeedItemsFuture.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
