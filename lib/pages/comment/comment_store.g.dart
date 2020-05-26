// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommentStore on _CommentStore, Store {
  final _$postIdAtom = Atom(name: '_CommentStore.postId');

  @override
  String get postId {
    _$postIdAtom.context.enforceReadPolicy(_$postIdAtom);
    _$postIdAtom.reportObserved();
    return super.postId;
  }

  @override
  set postId(String value) {
    _$postIdAtom.context.conditionallyRunInAction(() {
      super.postId = value;
      _$postIdAtom.reportChanged();
    }, _$postIdAtom, name: '${_$postIdAtom.name}_set');
  }

  final _$postTitleAtom = Atom(name: '_CommentStore.postTitle');

  @override
  String get postTitle {
    _$postTitleAtom.context.enforceReadPolicy(_$postTitleAtom);
    _$postTitleAtom.reportObserved();
    return super.postTitle;
  }

  @override
  set postTitle(String value) {
    _$postTitleAtom.context.conditionallyRunInAction(() {
      super.postTitle = value;
      _$postTitleAtom.reportChanged();
    }, _$postTitleAtom, name: '${_$postTitleAtom.name}_set');
  }

  final _$likesCountAtom = Atom(name: '_CommentStore.likesCount');

  @override
  int get likesCount {
    _$likesCountAtom.context.enforceReadPolicy(_$likesCountAtom);
    _$likesCountAtom.reportObserved();
    return super.likesCount;
  }

  @override
  set likesCount(int value) {
    _$likesCountAtom.context.conditionallyRunInAction(() {
      super.likesCount = value;
      _$likesCountAtom.reportChanged();
    }, _$likesCountAtom, name: '${_$likesCountAtom.name}_set');
  }

  final _$commentsCountAtom = Atom(name: '_CommentStore.commentsCount');

  @override
  int get commentsCount {
    _$commentsCountAtom.context.enforceReadPolicy(_$commentsCountAtom);
    _$commentsCountAtom.reportObserved();
    return super.commentsCount;
  }

  @override
  set commentsCount(int value) {
    _$commentsCountAtom.context.conditionallyRunInAction(() {
      super.commentsCount = value;
      _$commentsCountAtom.reportChanged();
    }, _$commentsCountAtom, name: '${_$commentsCountAtom.name}_set');
  }

  final _$apiErrorAtom = Atom(name: '_CommentStore.apiError');

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

  final _$errorAtom = Atom(name: '_CommentStore.error');

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

  final _$_loadFirstPageDataAsyncAction = AsyncAction('_loadFirstPageData');

  @override
  Future<dynamic> _loadFirstPageData() {
    return _$_loadFirstPageDataAsyncAction
        .run(() => super._loadFirstPageData());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('loadMoreData');

  @override
  Future<dynamic> loadMoreData({@required CommentModel after}) {
    return _$loadMoreDataAsyncAction
        .run(() => super.loadMoreData(after: after));
  }

  final _$_CommentStoreActionController =
      ActionController(name: '_CommentStore');

  @override
  dynamic setPostId(String postId) {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.setPostId(postId);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPostTitle(String postTitle) {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.setPostTitle(postTitle);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLikesCount(int count) {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.setLikesCount(count);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCommentsCount(int count) {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.setCommentsCount(count);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.retry();
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<CommentModel> submitComment({@required String comment}) {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.submitComment(comment: comment);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadData() {
    final _$actionInfo = _$_CommentStoreActionController.startAction();
    try {
      return super.loadData();
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'postId: ${postId.toString()},postTitle: ${postTitle.toString()},likesCount: ${likesCount.toString()},commentsCount: ${commentsCount.toString()},apiError: ${apiError.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
