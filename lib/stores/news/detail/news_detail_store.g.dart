// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsDetailStore on _NewsDetailStore, Store {
  final _$messageAtom = Atom(name: '_NewsDetailStore.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$openLinkAsyncAction = AsyncAction('_NewsDetailStore.openLink');

  @override
  Future openLink(String url) {
    return _$openLinkAsyncAction.run(() => super.openLink(url));
  }

  final _$_NewsDetailStoreActionController =
      ActionController(name: '_NewsDetailStore');

  @override
  dynamic bookmarkFeed(UserModel userModel) {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction(
        name: '_NewsDetailStore.bookmarkFeed');
    try {
      return super.bookmarkFeed(userModel);
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeBookmarkedFeed(String userId) {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction(
        name: '_NewsDetailStore.removeBookmarkedFeed');
    try {
      return super.removeBookmarkedFeed(userId);
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateMeta(PostMetaModel metaModel) {
    final _$actionInfo = _$_NewsDetailStoreActionController.startAction(
        name: '_NewsDetailStore.updateMeta');
    try {
      return super.updateMeta(metaModel);
    } finally {
      _$_NewsDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
message: ${message}
    ''';
  }
}
