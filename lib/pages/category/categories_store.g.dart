// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriesStore on _CategoriesStore, Store {
  final _$loadFeedItemsFutureAtom =
      Atom(name: '_CategoriesStore.loadFeedItemsFuture');

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

  final _$errorAtom = Atom(name: '_CategoriesStore.error');

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

  final _$apiErrorAtom = Atom(name: '_CategoriesStore.apiError');

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

  final _$viewAtom = Atom(name: '_CategoriesStore.view');

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

  final _$activeCategoryTabAtom =
      Atom(name: '_CategoriesStore.activeCategoryTab');

  @override
  String get activeCategoryTab {
    _$activeCategoryTabAtom.context.enforceReadPolicy(_$activeCategoryTabAtom);
    _$activeCategoryTabAtom.reportObserved();
    return super.activeCategoryTab;
  }

  @override
  set activeCategoryTab(String value) {
    _$activeCategoryTabAtom.context.conditionallyRunInAction(() {
      super.activeCategoryTab = value;
      _$activeCategoryTabAtom.reportChanged();
    }, _$activeCategoryTabAtom, name: '${_$activeCategoryTabAtom.name}_set');
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

  final _$_CategoriesStoreActionController =
      ActionController(name: '_CategoriesStore');

  @override
  void loadInitialFeeds(NewsCategory category) {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.loadInitialFeeds(category);
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry(NewsCategory category) {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.retry(category);
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(MenuItem value) {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.setView(value);
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setActiveCategoryTab(String categoryCode) {
    final _$actionInfo = _$_CategoriesStoreActionController.startAction();
    try {
      return super.setActiveCategoryTab(categoryCode);
    } finally {
      _$_CategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadFeedItemsFuture: ${loadFeedItemsFuture.toString()},error: ${error.toString()},apiError: ${apiError.toString()},view: ${view.toString()},activeCategoryTab: ${activeCategoryTab.toString()}';
    return '{$string}';
  }
}
