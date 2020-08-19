// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForexDetailStore on _ForexDetailStore, Store {
  final _$apiErrorAtom = Atom(name: '_ForexDetailStore.apiError');

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

  final _$errorAtom = Atom(name: '_ForexDetailStore.error');

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

  final _$refreshAsyncAction = AsyncAction('_ForexDetailStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_loadCurrencyDataAsyncAction =
      AsyncAction('_ForexDetailStore._loadCurrencyData');

  @override
  Future<dynamic> _loadCurrencyData() {
    return _$_loadCurrencyDataAsyncAction.run(() => super._loadCurrencyData());
  }

  final _$_ForexDetailStoreActionController =
      ActionController(name: '_ForexDetailStore');

  @override
  void retry() {
    final _$actionInfo = _$_ForexDetailStoreActionController.startAction(
        name: '_ForexDetailStore.retry');
    try {
      return super.retry();
    } finally {
      _$_ForexDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_ForexDetailStoreActionController.startAction(
        name: '_ForexDetailStore.loadData');
    try {
      return super.loadData();
    } finally {
      _$_ForexDetailStoreActionController.endAction(_$actionInfo);
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
