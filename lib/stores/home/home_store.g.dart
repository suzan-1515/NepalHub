// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$apiErrorAtom = Atom(name: '_HomeStore.apiError');

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

  final _$errorAtom = Atom(name: '_HomeStore.error');

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

  final _$viewAtom = Atom(name: '_HomeStore.view');

  @override
  ContentViewStyle get view {
    _$viewAtom.reportRead();
    return super.view;
  }

  @override
  set view(ContentViewStyle value) {
    _$viewAtom.reportWrite(value, super.view, () {
      super.view = value;
    });
  }

  final _$refreshAsyncAction = AsyncAction('_HomeStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_buildDataAsyncAction = AsyncAction('_HomeStore._buildData');

  @override
  Future<dynamic> _buildData() {
    return _$_buildDataAsyncAction.run(() => super._buildData());
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.retry');
    try {
      return super.retry();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(ContentViewStyle value) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setView');
    try {
      return super.setView(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> loadMoreData() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.loadMoreData');
    try {
      return super.loadMoreData();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiError: ${apiError},
error: ${error},
view: ${view}
    ''';
  }
}
