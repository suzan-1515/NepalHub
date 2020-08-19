// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalised_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PersonalisedNewsStore on _PersonalisedNewsStore, Store {
  final _$apiErrorAtom = Atom(name: '_PersonalisedNewsStore.apiError');

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

  final _$errorAtom = Atom(name: '_PersonalisedNewsStore.error');

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

  final _$viewAtom = Atom(name: '_PersonalisedNewsStore.view');

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

  final _$refreshAsyncAction = AsyncAction('_PersonalisedNewsStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_loadFirstPageDataAsyncAction =
      AsyncAction('_PersonalisedNewsStore._loadFirstPageData');

  @override
  Future<dynamic> _loadFirstPageData() {
    return _$_loadFirstPageDataAsyncAction
        .run(() => super._loadFirstPageData());
  }

  final _$loadMoreDataAsyncAction =
      AsyncAction('_PersonalisedNewsStore.loadMoreData');

  @override
  Future<dynamic> loadMoreData() {
    return _$loadMoreDataAsyncAction.run(() => super.loadMoreData());
  }

  final _$_PersonalisedNewsStoreActionController =
      ActionController(name: '_PersonalisedNewsStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_PersonalisedNewsStoreActionController.startAction(
        name: '_PersonalisedNewsStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_PersonalisedNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_PersonalisedNewsStoreActionController.startAction(
        name: '_PersonalisedNewsStore.retry');
    try {
      return super.retry();
    } finally {
      _$_PersonalisedNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(ContentViewStyle value) {
    final _$actionInfo = _$_PersonalisedNewsStoreActionController.startAction(
        name: '_PersonalisedNewsStore.setView');
    try {
      return super.setView(value);
    } finally {
      _$_PersonalisedNewsStoreActionController.endAction(_$actionInfo);
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
