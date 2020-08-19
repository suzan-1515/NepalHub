// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommentStore on _CommentStore, Store {
  final _$postIdAtom = Atom(name: '_CommentStore.postId');

  @override
  String get postId {
    _$postIdAtom.reportRead();
    return super.postId;
  }

  @override
  set postId(String value) {
    _$postIdAtom.reportWrite(value, super.postId, () {
      super.postId = value;
    });
  }

  final _$postTitleAtom = Atom(name: '_CommentStore.postTitle');

  @override
  String get postTitle {
    _$postTitleAtom.reportRead();
    return super.postTitle;
  }

  @override
  set postTitle(String value) {
    _$postTitleAtom.reportWrite(value, super.postTitle, () {
      super.postTitle = value;
    });
  }

  final _$apiErrorAtom = Atom(name: '_CommentStore.apiError');

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

  final _$errorAtom = Atom(name: '_CommentStore.error');

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

  final _$refreshAsyncAction = AsyncAction('_CommentStore.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$loadInitialDataAsyncAction =
      AsyncAction('_CommentStore.loadInitialData');

  @override
  Future<void> loadInitialData() {
    return _$loadInitialDataAsyncAction.run(() => super.loadInitialData());
  }

  final _$loadMoreDataAsyncAction = AsyncAction('_CommentStore.loadMoreData');

  @override
  Future<dynamic> loadMoreData({@required CommentModel after}) {
    return _$loadMoreDataAsyncAction
        .run(() => super.loadMoreData(after: after));
  }

  final _$_CommentStoreActionController =
      ActionController(name: '_CommentStore');

  @override
  dynamic setPostId(String postId) {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore.setPostId');
    try {
      return super.setPostId(postId);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPostTitle(String postTitle) {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore.setPostTitle');
    try {
      return super.setPostTitle(postTitle);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore.retry');
    try {
      return super.retry();
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> submitComment({@required String comment}) {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore.submitComment');
    try {
      return super.submitComment(comment: comment);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> likeComment({@required CommentModel comment}) {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore.likeComment');
    try {
      return super.likeComment(comment: comment);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> unlikeComment({@required CommentModel comment}) {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore.unlikeComment');
    try {
      return super.unlikeComment(comment: comment);
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> _loadFirstPageData() {
    final _$actionInfo = _$_CommentStoreActionController.startAction(
        name: '_CommentStore._loadFirstPageData');
    try {
      return super._loadFirstPageData();
    } finally {
      _$_CommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postId: ${postId},
postTitle: ${postTitle},
apiError: ${apiError},
error: ${error}
    ''';
  }
}
