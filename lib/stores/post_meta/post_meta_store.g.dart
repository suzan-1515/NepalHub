// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_meta_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostMetaStore on _PostMetaStore, Store {
  final _$postMetaAtom = Atom(name: '_PostMetaStore.postMeta');

  @override
  PostMetaModel get postMeta {
    _$postMetaAtom.reportRead();
    return super.postMeta;
  }

  @override
  set postMeta(PostMetaModel value) {
    _$postMetaAtom.reportWrite(value, super.postMeta, () {
      super.postMeta = value;
    });
  }

  final _$postLikeAsyncAction = AsyncAction('_PostMetaStore.postLike');

  @override
  Future<bool> postLike() {
    return _$postLikeAsyncAction.run(() => super.postLike());
  }

  final _$removeLikeAsyncAction = AsyncAction('_PostMetaStore.removeLike');

  @override
  Future<bool> removeLike() {
    return _$removeLikeAsyncAction.run(() => super.removeLike());
  }

  final _$postViewAsyncAction = AsyncAction('_PostMetaStore.postView');

  @override
  Future<void> postView() {
    return _$postViewAsyncAction.run(() => super.postView());
  }

  final _$postShareAsyncAction = AsyncAction('_PostMetaStore.postShare');

  @override
  Future<void> postShare() {
    return _$postShareAsyncAction.run(() => super.postShare());
  }

  final _$_PostMetaStoreActionController =
      ActionController(name: '_PostMetaStore');

  @override
  dynamic setPostMetaModel(PostMetaModel metaModel) {
    final _$actionInfo = _$_PostMetaStoreActionController.startAction(
        name: '_PostMetaStore.setPostMetaModel');
    try {
      return super.setPostMetaModel(metaModel);
    } finally {
      _$_PostMetaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loadPostMeta() {
    final _$actionInfo = _$_PostMetaStoreActionController.startAction(
        name: '_PostMetaStore.loadPostMeta');
    try {
      return super.loadPostMeta();
    } finally {
      _$_PostMetaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retry() {
    final _$actionInfo = _$_PostMetaStoreActionController.startAction(
        name: '_PostMetaStore.retry');
    try {
      return super.retry();
    } finally {
      _$_PostMetaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postMeta: ${postMeta}
    ''';
  }
}
