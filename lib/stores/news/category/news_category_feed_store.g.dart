// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category_feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsCategoryFeedStore on _NewsCategoryFeedStore, Store {
  final _$sourcesAtom = Atom(name: '_NewsCategoryFeedStore.sources');

  @override
  ObservableList<NewsSource> get sources {
    _$sourcesAtom.reportRead();
    return super.sources;
  }

  @override
  set sources(ObservableList<NewsSource> value) {
    _$sourcesAtom.reportWrite(value, super.sources, () {
      super.sources = value;
    });
  }

  final _$sortAtom = Atom(name: '_NewsCategoryFeedStore.sort');

  @override
  SortBy get sort {
    _$sortAtom.reportRead();
    return super.sort;
  }

  @override
  set sort(SortBy value) {
    _$sortAtom.reportWrite(value, super.sort, () {
      super.sort = value;
    });
  }

  final _$selectedSourceAtom =
      Atom(name: '_NewsCategoryFeedStore.selectedSource');

  @override
  NewsSource get selectedSource {
    _$selectedSourceAtom.reportRead();
    return super.selectedSource;
  }

  @override
  set selectedSource(NewsSource value) {
    _$selectedSourceAtom.reportWrite(value, super.selectedSource, () {
      super.selectedSource = value;
    });
  }

  final _$apiErrorAtom = Atom(name: '_NewsCategoryFeedStore.apiError');

  @override
  APIException get apiError {
    _$apiErrorAtom.reportRead();
    return super.apiError;
  }

  @override
  set apiError(APIException value) {
    _$apiErrorAtom.reportWrite(value, super.apiError, () {
      super.apiError = value;
    });
  }

  final _$errorAtom = Atom(name: '_NewsCategoryFeedStore.error');

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

  final _$_loadFirstPageDataAsyncAction =
      AsyncAction('_NewsCategoryFeedStore._loadFirstPageData');

  @override
  Future<dynamic> _loadFirstPageData() {
    return _$_loadFirstPageDataAsyncAction
        .run(() => super._loadFirstPageData());
  }

  final _$loadMoreDataAsyncAction =
      AsyncAction('_NewsCategoryFeedStore.loadMoreData');

  @override
  Future<dynamic> loadMoreData() {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData());
  }

  final _$_NewsCategoryFeedStoreActionController =
      ActionController(name: '_NewsCategoryFeedStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction(
        name: '_NewsCategoryFeedStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction(
        name: '_NewsCategoryFeedStore.retry');
    try {
      return super.retry();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> refresh() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction(
        name: '_NewsCategoryFeedStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> loadNewsSources() {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction(
        name: '_NewsCategoryFeedStore.loadNewsSources');
    try {
      return super.loadNewsSources();
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSortBy(SortBy value) {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction(
        name: '_NewsCategoryFeedStore.setSortBy');
    try {
      return super.setSortBy(value);
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSource(NewsSource source) {
    final _$actionInfo = _$_NewsCategoryFeedStoreActionController.startAction(
        name: '_NewsCategoryFeedStore.setSource');
    try {
      return super.setSource(source);
    } finally {
      _$_NewsCategoryFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sources: ${sources},
sort: ${sort},
selectedSource: ${selectedSource},
apiError: ${apiError},
error: ${error}
    ''';
  }
}
