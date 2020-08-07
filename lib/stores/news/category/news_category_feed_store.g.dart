// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category_feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsCategoryFeedStore on _NewsCategoryFeedStore, Store {
  final _$sourcesAtom = Atom(name: '_NewsCategoryFeedStore.sources');

  @override
  ObservableList<NewsSource> get sources {
    _$sourcesAtom.context.enforceReadPolicy(_$sourcesAtom);
    _$sourcesAtom.reportObserved();
    return super.sources;
  }

  @override
  set sources(ObservableList<NewsSource> value) {
    _$sourcesAtom.context.conditionallyRunInAction(() {
      super.sources = value;
      _$sourcesAtom.reportChanged();
    }, _$sourcesAtom, name: '${_$sourcesAtom.name}_set');
  }

  final _$sortAtom = Atom(name: '_NewsCategoryFeedStore.sort');

  @override
  SortBy get sort {
    _$sortAtom.context.enforceReadPolicy(_$sortAtom);
    _$sortAtom.reportObserved();
    return super.sort;
  }

  @override
  set sort(SortBy value) {
    _$sortAtom.context.conditionallyRunInAction(() {
      super.sort = value;
      _$sortAtom.reportChanged();
    }, _$sortAtom, name: '${_$sortAtom.name}_set');
  }

  final _$selectedSourceAtom =
      Atom(name: '_NewsCategoryFeedStore.selectedSource');

  @override
  NewsSource get selectedSource {
    _$selectedSourceAtom.context.enforceReadPolicy(_$selectedSourceAtom);
    _$selectedSourceAtom.reportObserved();
    return super.selectedSource;
  }

  @override
  set selectedSource(NewsSource value) {
    _$selectedSourceAtom.context.conditionallyRunInAction(() {
      super.selectedSource = value;
      _$selectedSourceAtom.reportChanged();
    }, _$selectedSourceAtom, name: '${_$selectedSourceAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_NewsCategoryFeedStore.apiError');

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

  final _$errorAtom = Atom(name: '_NewsCategoryFeedStore.error');

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

  final _$_loadFirstPageDataAsyncAction = AsyncAction('_loadFirstPageData');

  @override
  Future<dynamic> _loadFirstPageData() {
    return _$_loadFirstPageDataAsyncAction
        .run(() => super._loadFirstPageData());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('loadMoreData');

  @override
  Future<dynamic> loadMoreData() {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData());
  }

  final _$_NewsCategoryFeedStoreActionController =
      ActionController(name: '_NewsCategoryFeedStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction();
    try {
      return super.loadInitialData();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> refresh() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction();
    try {
      return super.refresh();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> loadNewsSources() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction();
    try {
      return super.loadNewsSources();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSortBy(SortBy value) {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction();
    try {
      return super.setSortBy(value);
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSource(NewsSource source) {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction();
    try {
      return super.setSource(source);
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'sources: ${sources.toString()},sort: ${sort.toString()},selectedSource: ${selectedSource.toString()},apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
