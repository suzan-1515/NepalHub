// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personalised_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PersonalisedFeedStore on _PersonalisedFeedStore, Store {
  final _$loadingStatusAtom =
      Atom(name: '_PersonalisedFeedStore.loadingStatus');

  @override
  bool get loadingStatus {
    _$loadingStatusAtom.context.enforceReadPolicy(_$loadingStatusAtom);
    _$loadingStatusAtom.reportObserved();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(bool value) {
    _$loadingStatusAtom.context.conditionallyRunInAction(() {
      super.loadingStatus = value;
      _$loadingStatusAtom.reportChanged();
    }, _$loadingStatusAtom, name: '${_$loadingStatusAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_PersonalisedFeedStore.apiError');

  @override
  APIError get apiError {
    _$apiErrorAtom.context.enforceReadPolicy(_$apiErrorAtom);
    _$apiErrorAtom.reportObserved();
    return super.apiError;
  }

  @override
  set apiError(APIError value) {
    _$apiErrorAtom.context.conditionallyRunInAction(() {
      super.apiError = value;
      _$apiErrorAtom.reportChanged();
    }, _$apiErrorAtom, name: '${_$apiErrorAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_PersonalisedFeedStore.error');

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

  final _$viewAtom = Atom(name: '_PersonalisedFeedStore.view');

  @override
  MenuItem get view {
    _$viewAtom.context.enforceReadPolicy(_$viewAtom);
    _$viewAtom.reportObserved();
    return super.view;
  }

  @override
  set view(MenuItem value) {
    _$viewAtom.context.conditionallyRunInAction(() {
      super.view = value;
      _$viewAtom.reportChanged();
    }, _$viewAtom, name: '${_$viewAtom.name}_set');
  }

  final _$fetchFeedsAsyncAction = AsyncAction('fetchFeeds');

  @override
  Future fetchFeeds() {
    return _$fetchFeedsAsyncAction.run(() => super.fetchFeeds());
  }

  final _$_PersonalisedFeedStoreActionController =
      ActionController(name: '_PersonalisedFeedStore');

  @override
  dynamic setView(MenuItem value) {
    final _$actionInfo = _$_PersonalisedFeedStoreActionController.startAction();
    try {
      return super.setView(value);
    } finally {
      _$_PersonalisedFeedStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadingStatus: ${loadingStatus.toString()},apiError: ${apiError.toString()},error: ${error.toString()},view: ${view.toString()}';
    return '{$string}';
  }
}
