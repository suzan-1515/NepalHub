// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corona_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CoronaStore on _CoronaStore, Store {
  final _$apiErrorAtom = Atom(name: '_CoronaStore.apiError');

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

  final _$errorAtom = Atom(name: '_CoronaStore.error');

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

  final _$_CoronaStoreActionController = ActionController(name: '_CoronaStore');

  @override
  dynamic loadWorldwideData() {
    final _$actionInfo = _$_CoronaStoreActionController.startAction(
        name: '_CoronaStore.loadWorldwideData');
    try {
      return super.loadWorldwideData();
    } finally {
      _$_CoronaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadNepalData() {
    final _$actionInfo = _$_CoronaStoreActionController.startAction(
        name: '_CoronaStore.loadNepalData');
    try {
      return super.loadNepalData();
    } finally {
      _$_CoronaStoreActionController.endAction(_$actionInfo);
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
