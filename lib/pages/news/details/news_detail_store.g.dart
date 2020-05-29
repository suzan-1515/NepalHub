// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsDetailStore on _NewsDetailStore, Store {
  final _$feedAtom = Atom(name: '_NewsDetailStore.feed');

  @override
  NewsFeedModel get feed {
    _$feedAtom.context.enforceReadPolicy(_$feedAtom);
    _$feedAtom.reportObserved();
    return super.feed;
  }

  @override
  set feed(NewsFeedModel value) {
    _$feedAtom.context.conditionallyRunInAction(() {
      super.feed = value;
      _$feedAtom.reportChanged();
    }, _$feedAtom, name: '${_$feedAtom.name}_set');
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
  dynamic setFeed(NewsFeedModel feed) {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction();
    try {
      return super.setFeed(feed);
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'feed: ${feed.toString()},message: ${message.toString()}';
    return '{$string}';
  }
}
