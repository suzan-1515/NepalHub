// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HoroscopeDetailStore on _HoroscopeDetailStore, Store {
  final _$messageAtom = Atom(name: '_HoroscopeDetailStore.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'message: ${message.toString()}';
    return '{$string}';
  }
}
