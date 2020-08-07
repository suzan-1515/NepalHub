// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HoroscopeStore on _HoroscopeStore, Store {
  final _$defaultZodiacAtom = Atom(name: '_HoroscopeStore.defaultZodiac');

  @override
  int get defaultZodiac {
    _$defaultZodiacAtom.context.enforceReadPolicy(_$defaultZodiacAtom);
    _$defaultZodiacAtom.reportObserved();
    return super.defaultZodiac;
  }

  @override
  set defaultZodiac(int value) {
    _$defaultZodiacAtom.context.conditionallyRunInAction(() {
      super.defaultZodiac = value;
      _$defaultZodiacAtom.reportChanged();
    }, _$defaultZodiacAtom, name: '${_$defaultZodiacAtom.name}_set');
  }

  final _$activeTabIndexAtom = Atom(name: '_HoroscopeStore.activeTabIndex');

  @override
  int get activeTabIndex {
    _$activeTabIndexAtom.context.enforceReadPolicy(_$activeTabIndexAtom);
    _$activeTabIndexAtom.reportObserved();
    return super.activeTabIndex;
  }

  @override
  set activeTabIndex(int value) {
    _$activeTabIndexAtom.context.conditionallyRunInAction(() {
      super.activeTabIndex = value;
      _$activeTabIndexAtom.reportChanged();
    }, _$activeTabIndexAtom, name: '${_$activeTabIndexAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_HoroscopeStore.apiError');

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

  final _$errorAtom = Atom(name: '_HoroscopeStore.error');

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

  final _$_loadDataAsyncAction = AsyncAction('_loadData');

  @override
  Future<dynamic> _loadData() {
    return _$_loadDataAsyncAction.run(() => super._loadData());
  }

  final _$_HoroscopeStoreActionController =
      ActionController(name: '_HoroscopeStore');

  @override
  void retry() {
    final _$actionInfo = _$_HoroscopeStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_HoroscopeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_HoroscopeStoreActionController.startAction();
    try {
      return super.loadData();
    } finally {
      _$_HoroscopeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'defaultZodiac: ${defaultZodiac.toString()},activeTabIndex: ${activeTabIndex.toString()},apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
