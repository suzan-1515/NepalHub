// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsCategoriesStore on _NewsCategoriesStore, Store {
  final _$apiErrorAtom = Atom(name: '_NewsCategoriesStore.apiError');

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

  final _$errorAtom = Atom(name: '_NewsCategoriesStore.error');

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

  final _$_NewsCategoriesStoreActionController =
      ActionController(name: '_NewsCategoriesStore');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_NewsCategoriesStoreActionController.startAction(
        name: '_NewsCategoriesStore.loadInitialData');
    try {
      return super.loadInitialData();
    } finally {
      _$_NewsCategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_NewsCategoriesStoreActionController.startAction(
        name: '_NewsCategoriesStore.retry');
    try {
      return super.retry();
    } finally {
      _$_NewsCategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> refresh() {
    final _$actionInfo = _$_NewsCategoriesStoreActionController.startAction(
        name: '_NewsCategoriesStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_NewsCategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> followedNewsCategory(NewsCategory categoryModel) {
    final _$actionInfo = _$_NewsCategoriesStoreActionController.startAction(
        name: '_NewsCategoriesStore.followedNewsCategory');
    try {
      return super.followedNewsCategory(categoryModel);
    } finally {
      _$_NewsCategoriesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> unFollowedNewsCategory(NewsCategory categoryModel) {
    final _$actionInfo = _$_NewsCategoriesStoreActionController.startAction(
        name: '_NewsCategoriesStore.unFollowedNewsCategory');
    try {
      return super.unFollowedNewsCategory(categoryModel);
    } finally {
      _$_NewsCategoriesStoreActionController.endAction(_$actionInfo);
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
