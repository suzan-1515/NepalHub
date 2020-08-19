// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForexStore on _ForexStore, Store {
  Computed<ForexModel> _$defaultForexComputed;

  @override
  ForexModel get defaultForex =>
      (_$defaultForexComputed ??= Computed<ForexModel>(() => super.defaultForex,
              name: '_ForexStore.defaultForex'))
          .value;

  final _$defaultForexTimelineAtom =
      Atom(name: '_ForexStore.defaultForexTimeline');

  @override
  ObservableList<ForexModel> get defaultForexTimeline {
    _$defaultForexTimelineAtom.reportRead();
    return super.defaultForexTimeline;
  }

  @override
  set defaultForexTimeline(ObservableList<ForexModel> value) {
    _$defaultForexTimelineAtom.reportWrite(value, super.defaultForexTimeline,
        () {
      super.defaultForexTimeline = value;
    });
  }

  final _$apiErrorAtom = Atom(name: '_ForexStore.apiError');

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

  final _$errorAtom = Atom(name: '_ForexStore.error');

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

  final _$_loadTodayDataAsyncAction = AsyncAction('_ForexStore._loadTodayData');

  @override
  Future<dynamic> _loadTodayData() {
    return _$_loadTodayDataAsyncAction.run(() => super._loadTodayData());
  }

  final _$_loadDefaultCurrencyTimelineDataAsyncAction =
      AsyncAction('_ForexStore._loadDefaultCurrencyTimelineData');

  @override
  Future<dynamic> _loadDefaultCurrencyTimelineData() {
    return _$_loadDefaultCurrencyTimelineDataAsyncAction
        .run(() => super._loadDefaultCurrencyTimelineData());
  }

  final _$_ForexStoreActionController = ActionController(name: '_ForexStore');

  @override
  void retry() {
    final _$actionInfo =
        _$_ForexStoreActionController.startAction(name: '_ForexStore.retry');
    try {
      return super.retry();
    } finally {
      _$_ForexStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo =
        _$_ForexStoreActionController.startAction(name: '_ForexStore.loadData');
    try {
      return super.loadData();
    } finally {
      _$_ForexStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
defaultForexTimeline: ${defaultForexTimeline},
apiError: ${apiError},
error: ${error},
defaultForex: ${defaultForex}
    ''';
  }
}
