// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FollowingStore on _FollowingStore, Store {
  final _$errorAtom = Atom(name: '_FollowingStore.error');

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

  final _$messageAtom = Atom(name: '_FollowingStore.message');

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

  final _$refreshAsyncAction = AsyncAction('_FollowingStore.refresh');

  @override
  Future<dynamic> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_FollowingStoreActionController =
      ActionController(name: '_FollowingStore');

  @override
  dynamic retryNewsSources() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.retryNewsSources');
    try {
      return super.retryNewsSources();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryNewsCategory() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.retryNewsCategory');
    try {
      return super.retryNewsCategory();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryNewsTopic() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.retryNewsTopic');
    try {
      return super.retryNewsTopic();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsSourceData() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.loadFollowedNewsSourceData');
    try {
      return super.loadFollowedNewsSourceData();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsCategoryData() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.loadFollowedNewsCategoryData');
    try {
      return super.loadFollowedNewsCategoryData();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsTopicData() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.loadFollowedNewsTopicData');
    try {
      return super.loadFollowedNewsTopicData();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
message: ${message}
    ''';
  }
}
