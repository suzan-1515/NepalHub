// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HoroscopeStore on _HoroscopeStore, Store {
  final _$defaultZodiacAtom = Atom(name: '_HoroscopeStore.defaultZodiac');

  @override
  int get defaultZodiac {
    _$defaultZodiacAtom.reportRead();
    return super.defaultZodiac;
  }

  @override
  set defaultZodiac(int value) {
    _$defaultZodiacAtom.reportWrite(value, super.defaultZodiac, () {
      super.defaultZodiac = value;
    });
  }

  final _$activeTabIndexAtom = Atom(name: '_HoroscopeStore.activeTabIndex');

  @override
  int get activeTabIndex {
    _$activeTabIndexAtom.reportRead();
    return super.activeTabIndex;
  }

  @override
  set activeTabIndex(int value) {
    _$activeTabIndexAtom.reportWrite(value, super.activeTabIndex, () {
      super.activeTabIndex = value;
    });
  }

  final _$apiErrorAtom = Atom(name: '_HoroscopeStore.apiError');

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

  final _$errorAtom = Atom(name: '_HoroscopeStore.error');

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

  final _$_loadDataAsyncAction = AsyncAction('_HoroscopeStore._loadData');

  @override
  Future<dynamic> _loadData() {
    return _$_loadDataAsyncAction.run(() => super._loadData());
  }

  final _$_HoroscopeStoreActionController =
      ActionController(name: '_HoroscopeStore');

  @override
  void retry() {
    final _$actionInfo = _$_HoroscopeStoreActionController.startAction(
        name: '_HoroscopeStore.retry');
    try {
      return super.retry();
    } finally {
      _$_HoroscopeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_HoroscopeStoreActionController.startAction(
        name: '_HoroscopeStore.loadData');
    try {
      return super.loadData();
    } finally {
      _$_HoroscopeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
defaultZodiac: ${defaultZodiac},
activeTabIndex: ${activeTabIndex},
apiError: ${apiError},
error: ${error}
    ''';
  }
}
