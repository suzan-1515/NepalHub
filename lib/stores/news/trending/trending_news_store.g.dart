// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrendingNewsStore on _TrendingNewsStore, Store {
  final _$apiErrorAtom = Atom(name: '_TrendingNewsStore.apiError');

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

  final _$errorAtom = Atom(name: '_TrendingNewsStore.error');

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

  final _$refreshAsyncAction = AsyncAction('_TrendingNewsStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_TrendingNewsStoreActionController =
      ActionController(name: '_TrendingNewsStore');

  @override
  void retry() {
    final _$actionInfo = _$_TrendingNewsStoreActionController.startAction(
        name: '_TrendingNewsStore.retry');
    try {
      return super.retry();
    } finally {
      _$_TrendingNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_TrendingNewsStoreActionController.startAction(
        name: '_TrendingNewsStore.loadData');
    try {
      return super.loadData();
    } finally {
      _$_TrendingNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> _loadFirstPageData() {
    final _$actionInfo = _$_TrendingNewsStoreActionController.startAction(
        name: '_TrendingNewsStore._loadFirstPageData');
    try {
      return super._loadFirstPageData();
    } finally {
      _$_TrendingNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiError: ${apiError},
error: ${error}
    ''';
  }
}
