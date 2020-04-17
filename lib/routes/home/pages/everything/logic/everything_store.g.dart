// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'everything_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EverythingStore on _EverythingStore, Store {
  final _$loadFeedItemsFutureAtom =
      Atom(name: '_EverythingStore.loadFeedItemsFuture');

  @override
  ObservableMap<NewsCategory, ObservableFuture<dynamic>>
      get loadFeedItemsFuture {
    _$loadFeedItemsFutureAtom.context
        .enforceReadPolicy(_$loadFeedItemsFutureAtom);
    _$loadFeedItemsFutureAtom.reportObserved();
    return super.loadFeedItemsFuture;
  }

  @override
  set loadFeedItemsFuture(
      ObservableMap<NewsCategory, ObservableFuture<dynamic>> value) {
    _$loadFeedItemsFutureAtom.context.conditionallyRunInAction(() {
      super.loadFeedItemsFuture = value;
      _$loadFeedItemsFutureAtom.reportChanged();
    }, _$loadFeedItemsFutureAtom,
        name: '${_$loadFeedItemsFutureAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_EverythingStore.apiError');

  @override
  APIError get apiError {
    _$apiErrorAtom.context.enforceReadPolicy(_$apiErrorAtom);
    _$apiErrorAtom.reportObserved();
    return super.apiError;
  }

  @override
  set apiError(APIError value) {
    _$apiErrorAtom.context.conditionallyRunInAction(() {
      super.apiError = value;
      _$apiErrorAtom.reportChanged();
    }, _$apiErrorAtom, name: '${_$apiErrorAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_EverythingStore.error');

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

  final _$viewAtom = Atom(name: '_EverythingStore.view');

  @override
  MenuItem get view {
    _$viewAtom.context.enforceReadPolicy(_$viewAtom);
    _$viewAtom.reportObserved();
    return super.view;
  }

  @override
  set view(MenuItem value) {
    _$viewAtom.context.conditionallyRunInAction(() {
      super.view = value;
      _$viewAtom.reportChanged();
    }, _$viewAtom, name: '${_$viewAtom.name}_set');
  }

  final _$activeTabIndexAtom = Atom(name: '_EverythingStore.activeTabIndex');

  @override
  int get activeTabIndex {
    _$activeTabIndexAtom.context.enforceReadPolicy(_$activeTabIndexAtom);
    _$activeTabIndexAtom.reportObserved();
    return super.activeTabIndex;
  }

  @override
  set activeTabIndex(int value) {
    _$activeTabIndexAtom.context.conditionallyRunInAction(() {
      super.activeTabIndex = value;
      _$activeTabIndexAtom.reportChanged();
    }, _$activeTabIndexAtom, name: '${_$activeTabIndexAtom.name}_set');
  }

  final _$_loadFirstPageFeedsAsyncAction = AsyncAction('_loadFirstPageFeeds');

  @override
  Future<void> _loadFirstPageFeeds(NewsCategory category) {
    return _$_loadFirstPageFeedsAsyncAction
        .run(() => super._loadFirstPageFeeds(category));
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh(NewsCategory category) {
    return _$refreshAsyncAction.run(() => super.refresh(category));
  }

  final _$loadMoreDataAsyncAction = AsyncAction('loadMoreData');

  @override
  Future<void> loadMoreData(NewsCategory category) {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData(category));
  }

  final _$_EverythingStoreActionController =
      ActionController(name: '_EverythingStore');

  @override
  void loadInitialFeeds(NewsCategory category) {
    final _$actionInfo = _$_EverythingStoreActionController.startAction();
    try {
      return super.loadInitialFeeds(category);
    } finally {
      _$_EverythingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry(NewsCategory category) {
    final _$actionInfo = _$_EverythingStoreActionController.startAction();
    try {
      return super.retry(category);
    } finally {
      _$_EverythingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(MenuItem value) {
    final _$actionInfo = _$_EverythingStoreActionController.startAction();
    try {
      return super.setView(value);
    } finally {
      _$_EverythingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setActiveTab(int value) {
    final _$actionInfo = _$_EverythingStoreActionController.startAction();
    try {
      return super.setActiveTab(value);
    } finally {
      _$_EverythingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadFeedItemsFuture: ${loadFeedItemsFuture.toString()},apiError: ${apiError.toString()},error: ${error.toString()},view: ${view.toString()},activeTabIndex: ${activeTabIndex.toString()}';
    return '{$string}';
  }
}
