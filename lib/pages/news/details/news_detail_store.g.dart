// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsDetailStore on _NewsDetailStore, Store {
  final _$bookmarkStatusAtom = Atom(name: '_NewsDetailStore.bookmarkStatus');

  @override
  bool get bookmarkStatus {
    _$bookmarkStatusAtom.context.enforceReadPolicy(_$bookmarkStatusAtom);
    _$bookmarkStatusAtom.reportObserved();
    return super.bookmarkStatus;
  }

  @override
  set bookmarkStatus(bool value) {
    _$bookmarkStatusAtom.context.conditionallyRunInAction(() {
      super.bookmarkStatus = value;
      _$bookmarkStatusAtom.reportChanged();
    }, _$bookmarkStatusAtom, name: '${_$bookmarkStatusAtom.name}_set');
  }

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
  dynamic bookmarkFeed() {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction();
    try {
      return super.bookmarkFeed();
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeBookmarkedFeed() {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction();
    try {
      return super.removeBookmarkedFeed();
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'bookmarkStatus: ${bookmarkStatus.toString()},message: ${message.toString()}';
    return '{$string}';
  }
}
