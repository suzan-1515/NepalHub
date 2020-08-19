// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsCategoryScreenStore on _NewsCategoryScreenStore, Store {
  final _$errorAtom = Atom(name: '_NewsCategoryScreenStore.error');

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

  final _$apiErrorAtom = Atom(name: '_NewsCategoryScreenStore.apiError');

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

  final _$activeCategoryTabAtom =
      Atom(name: '_NewsCategoryScreenStore.activeCategoryTab');

  @override
  String get activeCategoryTab {
    _$activeCategoryTabAtom.reportRead();
    return super.activeCategoryTab;
  }

  @override
  set activeCategoryTab(String value) {
    _$activeCategoryTabAtom.reportWrite(value, super.activeCategoryTab, () {
      super.activeCategoryTab = value;
    });
  }

  final _$viewAtom = Atom(name: '_NewsCategoryScreenStore.view');

  @override
  ContentViewStyle get view {
    _$viewAtom.reportRead();
    return super.view;
  }

  @override
  set view(ContentViewStyle value) {
    _$viewAtom.reportWrite(value, super.view, () {
      super.view = value;
    });
  }

  final _$refreshAsyncAction = AsyncAction('_NewsCategoryScreenStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_loadCategoriesAsyncAction =
      AsyncAction('_NewsCategoryScreenStore._loadCategories');

  @override
  Future<void> _loadCategories() {
    return _$_loadCategoriesAsyncAction.run(() => super._loadCategories());
  }

  final _$_NewsCategoryScreenStoreActionController =
      ActionController(name: '_NewsCategoryScreenStore');

  @override
  void loadData() {
    final _$actionInfo = _$_NewsCategoryScreenStoreActionController.startAction(
        name: '_NewsCategoryScreenStore.loadData');
    try {
      return super.loadData();
    } finally {
      _$_NewsCategoryScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_NewsCategoryScreenStoreActionController.startAction(
        name: '_NewsCategoryScreenStore.retry');
    try {
      return super.retry();
    } finally {
      _$_NewsCategoryScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setActiveCategoryTab(String categoryCode) {
    final _$actionInfo = _$_NewsCategoryScreenStoreActionController.startAction(
        name: '_NewsCategoryScreenStore.setActiveCategoryTab');
    try {
      return super.setActiveCategoryTab(categoryCode);
    } finally {
      _$_NewsCategoryScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setView(ContentViewStyle value) {
    final _$actionInfo = _$_NewsCategoryScreenStoreActionController.startAction(
        name: '_NewsCategoryScreenStore.setView');
    try {
      return super.setView(value);
    } finally {
      _$_NewsCategoryScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
apiError: ${apiError},
activeCategoryTab: ${activeCategoryTab},
view: ${view}
    ''';
  }
}
