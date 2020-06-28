// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavouritesStore on _FavouritesStore, Store {
  final _$errorAtom = Atom(name: '_FavouritesStore.error');

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

  final _$messageAtom = Atom(name: '_FavouritesStore.message');

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

  final _$_FavouritesStoreActionController =
      ActionController(name: '_FavouritesStore');

  @override
  dynamic retryNewsSources() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.retryNewsSources();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryNewsCategory() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.retryNewsCategory();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryNewsTopic() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.retryNewsTopic();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsSourceData() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.loadFollowedNewsSourceData();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsCategoryData() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.loadFollowedNewsCategoryData();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> loadFollowedNewsTopicData() {
    final _$actionInfo = _$_FavouritesStoreActionController.startAction();
    try {
      return super.loadFollowedNewsTopicData();
    } finally {
      _$_FavouritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'error: ${error.toString()},message: ${message.toString()}';
    return '{$string}';
  }
}
