// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsDetailStore on _NewsDetailStore, Store {
  final _$messageAtom = Atom(name: '_NewsDetailStore.message');

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

  final _$_NewsDetailStoreActionController =
      ActionController(name: '_NewsDetailStore');

  @override
  dynamic share() {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction();
    try {
      return super.share();
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openLink() {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction();
    try {
      return super.openLink();
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'message: ${message.toString()}';
    return '{$string}';
  }
}