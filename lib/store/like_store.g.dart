// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LikeStore on _LikeStore, Store {
  final _$errorAtom = Atom(name: '_LikeStore.error');

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

  final _$addLikedFeedAsyncAction = AsyncAction('addLikedFeed');

  @override
  Future<bool> addLikedFeed({@required Feed feed}) {
    return _$addLikedFeedAsyncAction.run(() => super.addLikedFeed(feed: feed));
  }

  final _$removeLikedFeedAsyncAction = AsyncAction('removeLikedFeed');

  @override
  Future<bool> removeLikedFeed({@required Feed feed}) {
    return _$removeLikedFeedAsyncAction
        .run(() => super.removeLikedFeed(feed: feed));
  }

  final _$isLikedFeedAsyncAction = AsyncAction('isLikedFeed');

  @override
  Future<bool> isLikedFeed({@required Feed feed}) {
    return _$isLikedFeedAsyncAction.run(() => super.isLikedFeed(feed: feed));
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_LikeStoreActionController = ActionController(name: '_LikeStore');

  @override
  void retry() {
    final _$actionInfo = _$_LikeStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_LikeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'error: ${error.toString()}';
    return '{$string}';
  }
}
