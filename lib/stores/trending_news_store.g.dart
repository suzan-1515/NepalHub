// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_news_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TrendingNewsStore on _TrendingNewsStore, Store {
  final _$currentNewsCarouselAtom =
      Atom(name: '_TrendingNewsStore.currentNewsCarousel');

  @override
  int get currentNewsCarousel {
    _$currentNewsCarouselAtom.context
        .enforceReadPolicy(_$currentNewsCarouselAtom);
    _$currentNewsCarouselAtom.reportObserved();
    return super.currentNewsCarousel;
  }

  @override
  set currentNewsCarousel(int value) {
    _$currentNewsCarouselAtom.context.conditionallyRunInAction(() {
      super.currentNewsCarousel = value;
      _$currentNewsCarouselAtom.reportChanged();
    }, _$currentNewsCarouselAtom,
        name: '${_$currentNewsCarouselAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_TrendingNewsStore.apiError');

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

  final _$errorAtom = Atom(name: '_TrendingNewsStore.error');

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

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$_TrendingNewsStoreActionController =
      ActionController(name: '_TrendingNewsStore');

  @override
  dynamic loadPreviewData() {
    final _$actionInfo = _$_TrendingNewsStoreActionController.startAction();
    try {
      return super.loadPreviewData();
    } finally {
      _$_TrendingNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadFullData() {
    final _$actionInfo = _$_TrendingNewsStoreActionController.startAction();
    try {
      return super.loadFullData();
    } finally {
      _$_TrendingNewsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'currentNewsCarousel: ${currentNewsCarousel.toString()},apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
