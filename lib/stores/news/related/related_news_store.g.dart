// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'related_news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RelatedNewsStore on _RelatedNewsStore, Store {
  final _$apiErrorAtom = Atom(name: '_RelatedNewsStore.apiError');

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

  final _$errorAtom = Atom(name: '_RelatedNewsStore.error');

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

  final _$refreshAsyncAction = AsyncAction('_RelatedNewsStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_RelatedNewsStoreActionController =
      ActionController(name: '_RelatedNewsStore');

  @override
  void retry() {
    final _$actionInfo = _$_RelatedNewsStoreActionController.startAction(
        name: '_RelatedNewsStore.retry');
    try {
      return super.retry();
    } finally {
      _$_RelatedNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadInitialData() {
    final _$actionInfo = _$_RelatedNewsStoreActionController.startAction(
        name: '_RelatedNewsStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_RelatedNewsStoreActionController.endAction(_$actionInfo);
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
