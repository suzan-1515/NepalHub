// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForexStore on _ForexStore, Store {
  Computed<ForexModel> _$defaultForexComputed;

  @override
  ForexModel get defaultForex => (_$defaultForexComputed ??=
          Computed<ForexModel>(() => super.defaultForex))
      .value;

  final _$defaultForexTimelineAtom =
      Atom(name: '_ForexStore.defaultForexTimeline');

  @override
  ObservableList<ForexModel> get defaultForexTimeline {
    _$defaultForexTimelineAtom.context
        .enforceReadPolicy(_$defaultForexTimelineAtom);
    _$defaultForexTimelineAtom.reportObserved();
    return super.defaultForexTimeline;
  }

  @override
  set defaultForexTimeline(ObservableList<ForexModel> value) {
    _$defaultForexTimelineAtom.context.conditionallyRunInAction(() {
      super.defaultForexTimeline = value;
      _$defaultForexTimelineAtom.reportChanged();
    }, _$defaultForexTimelineAtom,
        name: '${_$defaultForexTimelineAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_ForexStore.apiError');

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

  final _$errorAtom = Atom(name: '_ForexStore.error');

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

  final _$_loadTodayDataAsyncAction = AsyncAction('_loadTodayData');

  @override
  Future<dynamic> _loadTodayData() {
    return _$_loadTodayDataAsyncAction.run(() => super._loadTodayData());
  }

  final _$_loadDefaultCurrencyTimelineDataAsyncAction =
      AsyncAction('_loadDefaultCurrencyTimelineData');

  @override
  Future<dynamic> _loadDefaultCurrencyTimelineData() {
    return _$_loadDefaultCurrencyTimelineDataAsyncAction
        .run(() => super._loadDefaultCurrencyTimelineData());
  }

  final _$_ForexStoreActionController = ActionController(name: '_ForexStore');

  @override
  void retry() {
    final _$actionInfo = _$_ForexStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_ForexStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_ForexStoreActionController.startAction();
    try {
      return super.loadData();
    } finally {
      _$_ForexStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'defaultForexTimeline: ${defaultForexTimeline.toString()},apiError: ${apiError.toString()},error: ${error.toString()},defaultForex: ${defaultForex.toString()}';
    return '{$string}';
  }
}
