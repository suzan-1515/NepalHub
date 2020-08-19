// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_source_feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsSourceFeedStore on _NewsSourceFeedStore, Store {
  final _$sourcesAtom = Atom(name: '_NewsSourceFeedStore.sources');

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

  final _$sortAtom = Atom(name: '_NewsSourceFeedStore.sort');

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
      Atom(name: '_NewsSourceFeedStore.selectedSource');

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

  final _$apiErrorAtom = Atom(name: '_NewsSourceFeedStore.apiError');

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

  final _$errorAtom = Atom(name: '_NewsSourceFeedStore.error');

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
      AsyncAction('_NewsSourceFeedStore._loadFirstPageData');

  @override
  Future<dynamic> _loadFirstPageData() {
    return _$_loadFirstPageDataAsyncAction
        .run(() => super._loadFirstPageData());
  }

  final _$loadMoreDataAsyncAction =
      AsyncAction('_NewsSourceFeedStore.loadMoreData');

  @override
  Future<dynamic> loadMoreData() {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData());
  }

  final _$_NewsSourceFeedStoreActionController =
      ActionController(name: '_NewsSourceFeedStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_NewsSourceFeedStoreActionController.startAction(
        name: '_NewsSourceFeedStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_NewsSourceFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_NewsSourceFeedStoreActionController.startAction(
        name: '_NewsSourceFeedStore.retry');
    try {
      return super.retry();
    } finally {
      _$_NewsSourceFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> refresh() {
    final _$actionInfo = _$_NewsSourceFeedStoreActionController.startAction(
        name: '_NewsSourceFeedStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_NewsSourceFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> loadNewsSources() {
    final _$actionInfo = _$_NewsSourceFeedStoreActionController.startAction(
        name: '_NewsSourceFeedStore.loadNewsSources');
    try {
      return super.loadNewsSources();
    } finally {
      _$_NewsSourceFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSortBy(SortBy value) {
    final _$actionInfo = _$_NewsSourceFeedStoreActionController.startAction(
        name: '_NewsSourceFeedStore.setSortBy');
    try {
      return super.setSortBy(value);
    } finally {
      _$_NewsSourceFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSource(NewsSource source) {
    final _$actionInfo = _$_NewsSourceFeedStoreActionController.startAction(
        name: '_NewsSourceFeedStore.setSource');
    try {
      return super.setSource(source);
    } finally {
      _$_NewsSourceFeedStoreActionController.endAction(_$actionInfo);
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
