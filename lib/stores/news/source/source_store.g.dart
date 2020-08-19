// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsSourceStore on _NewsSourceStore, Store {
  final _$apiErrorAtom = Atom(name: '_NewsSourceStore.apiError');

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

  final _$errorAtom = Atom(name: '_NewsSourceStore.error');

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

  final _$_NewsSourceStoreActionController =
      ActionController(name: '_NewsSourceStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_NewsSourceStoreActionController.startAction(
        name: '_NewsSourceStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_NewsSourceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_NewsSourceStoreActionController.startAction(
        name: '_NewsSourceStore.retry');
    try {
      return super.retry();
    } finally {
      _$_NewsSourceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> refresh() {
    final _$actionInfo = _$_NewsSourceStoreActionController.startAction(
        name: '_NewsSourceStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_NewsSourceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> followedNewsSource(NewsSource sourceModel) {
    final _$actionInfo = _$_NewsSourceStoreActionController.startAction(
        name: '_NewsSourceStore.followedNewsSource');
    try {
      return super.followedNewsSource(sourceModel);
    } finally {
      _$_NewsSourceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> unFollowedNewsSource(NewsSource sourceModel) {
    final _$actionInfo = _$_NewsSourceStoreActionController.startAction(
        name: '_NewsSourceStore.unFollowedNewsSource');
    try {
      return super.unFollowedNewsSource(sourceModel);
    } finally {
      _$_NewsSourceStoreActionController.endAction(_$actionInfo);
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
