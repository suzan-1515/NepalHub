// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForexDetailStore on _ForexDetailStore, Store {
  final _$apiErrorAtom = Atom(name: '_ForexDetailStore.apiError');

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

  final _$errorAtom = Atom(name: '_ForexDetailStore.error');

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

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_loadCurrencyDataAsyncAction = AsyncAction('_loadCurrencyData');

  @override
  Future<dynamic> _loadCurrencyData() {
    return _$_loadCurrencyDataAsyncAction.run(() => super._loadCurrencyData());
  }

  final _$_ForexDetailStoreActionController =
      ActionController(name: '_ForexDetailStore');

  @override
  dynamic setFromDate(String fromDate) {
    final _$actionInfo = _$_ForexDetailStoreActionController.startAction();
    try {
      return super.setFromDate(fromDate);
    } finally {
      _$_ForexDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setToDate(String toDate) {
    final _$actionInfo = _$_ForexDetailStoreActionController.startAction();
    try {
      return super.setToDate(toDate);
    } finally {
      _$_ForexDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_ForexDetailStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_ForexDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_ForexDetailStoreActionController.startAction();
    try {
      return super.loadData();
    } finally {
      _$_ForexDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
