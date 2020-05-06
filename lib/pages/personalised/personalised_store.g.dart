// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalised_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PersonalisedFeedStore on _PersonalisedFeedStore, Store {
  final _$loadFeedItemsFutureAtom =
      Atom(name: '_PersonalisedFeedStore.loadFeedItemsFuture');

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

  final _$apiErrorAtom = Atom(name: '_PersonalisedFeedStore.apiError');

  @override
  APIException get apiError {
    _$apiErrorAtom.context.enforceReadPolicy(_$apiErrorAtom);
    _$apiErrorAtom.reportObserved();
    return super.apiError;
  }

  @override
  set apiError(APIException value) {
    _$apiErrorAtom.context.conditionallyRunInAction(() {
      super.apiError = value;
      _$apiErrorAtom.reportChanged();
    }, _$apiErrorAtom, name: '${_$apiErrorAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_PersonalisedFeedStore.error');

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

  final _$viewAtom = Atom(name: '_PersonalisedFeedStore.view');

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

  final _$_loadFirstPageFeedsAsyncAction = AsyncAction('_loadFirstPageFeeds');

  @override
  Future<void> _loadFirstPageFeeds() {
    return _$_loadFirstPageFeedsAsyncAction
        .run(() => super._loadFirstPageFeeds());
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('loadMoreData');

  @override
  Future<void> loadMoreData() {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData());
  }

  final _$_PersonalisedFeedStoreActionController =
      ActionController(name: '_PersonalisedFeedStore');

  @override
  void loadInitialFeeds() {
    final _$actionInfo = _$_PersonalisedFeedStoreActionController.startAction();
    try {
      return super.loadInitialFeeds();
    } finally {
      _$_PersonalisedFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_PersonalisedFeedStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_PersonalisedFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(MenuItem value) {
    final _$actionInfo = _$_PersonalisedFeedStoreActionController.startAction();
    try {
      return super.setView(value);
    } finally {
      _$_PersonalisedFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadFeedItemsFuture: ${loadFeedItemsFuture.toString()},apiError: ${apiError.toString()},error: ${error.toString()},view: ${view.toString()}';
    return '{$string}';
  }
}
