// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FollowingStore on _FollowingStore, Store {
  final _$errorAtom = Atom(name: '_FollowingStore.error');

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

  final _$messageAtom = Atom(name: '_FollowingStore.message');

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

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<dynamic> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_FollowingStoreActionController =
      ActionController(name: '_FollowingStore');

  @override
  dynamic retryNewsSources() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction();
    try {
      return super.retryNewsSources();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryNewsCategory() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction();
    try {
      return super.retryNewsCategory();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryNewsTopic() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction();
    try {
      return super.retryNewsTopic();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsSourceData() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction();
    try {
      return super.loadFollowedNewsSourceData();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsCategoryData() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction();
    try {
      return super.loadFollowedNewsCategoryData();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsTopicData() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction();
    try {
      return super.loadFollowedNewsTopicData();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'error: ${error.toString()},message: ${message.toString()}';
    return '{$string}';
  }
}
