// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FollowNewsCategoryStore on _FollowNewsCategoryStore, Store {
  final _$apiErrorAtom = Atom(name: '_FavouriteNewsCategoryStore.apiError');

  @override
  APIException get apiError {
    _$apiErrorAtom.context.enforceReadPolicy(_$apiErrorAtom);
    _$apiErrorAtom.reportObserved();
    return super.apiError;
  }

  @override
  set apiError(APIException value) {
    _$apiErrorAtom.context.conditionallyRunInAction(() {
      super.apiError = value;
      _$apiErrorAtom.reportChanged();
    }, _$apiErrorAtom, name: '${_$apiErrorAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_FavouriteNewsCategoryStore.error');

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

  final _$_FavouriteNewsCategoryStoreActionController =
      ActionController(name: '_FavouriteNewsCategoryStore');

  @override
  void loadInitialData() {
    final _$actionInfo =
        _$_FavouriteNewsCategoryStoreActionController.startAction();
    try {
      return super.loadInitialData();
    } finally {
      _$_FavouriteNewsCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo =
        _$_FavouriteNewsCategoryStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_FavouriteNewsCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> updateFollowedNewsCategory() {
    final _$actionInfo =
        _$_FavouriteNewsCategoryStoreActionController.startAction();
    try {
      return super.updateFollowedNewsCategory();
    } finally {
      _$_FavouriteNewsCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
