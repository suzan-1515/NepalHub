import 'package:flutter/widgets.dart';

import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';

part 'post_meta_store.g.dart';

class PostMetaStore = _PostMetaStore with _$PostMetaStore;

abstract class _PostMetaStore with Store {
  final PostMetaRepository _postMetaRepository;
  final UserModel _user;
  final String postId;

  _PostMetaStore(this._postMetaRepository, this._user, this.postId);

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  @observable
  PostMetaModel postMeta;

  @action
  setPostMetaModel(PostMetaModel metaModel) {
    this.postMeta = metaModel;
  }

  @action
  loadPostMeta() {
    _loadPostMetaAsStream();
  }

  @action
  retry() {
    _loadPostMetaAsStream();
  }

  @action
  Future<bool> postLike() async {
    if (_user == null || inProgress) return false;
    _inProgress = true;
    return _postMetaRepository
        .postLike(postId: postId, userId: _user.uId)
        .then((value) => true)
        .catchError((onError) {
      debugPrint('Error posting like: ' + onError.toString());
      return false;
    }).whenComplete(() => _inProgress = false);
  }

  @action
  Future<bool> removeLike() async {
    if (_user == null || inProgress) return false;
    _inProgress = true;
    return _postMetaRepository
        .removeLike(postId: postId, userId: _user.uId)
        .then((value) => true)
        .catchError((onError) {
      debugPrint('Error removing like: ' + onError.toString());
      return false;
    }).whenComplete(() => _inProgress = false);
  }

  @action
  Future<void> postView() async {
    if (_user == null) return;
    return _postMetaRepository
        .postView(postId: postId, userId: _user.uId)
        .catchError((onError) {
      debugPrint('Error posting view: ' + onError.toString());
    });
  }

  @action
  Future<void> postShare() async {
    if (_user == null) return;
    return _postMetaRepository
        .postShare(postId: postId, userId: _user.uId)
        .catchError((onError) {
      debugPrint('Error posting share: ' + onError.toString());
    });
  }

  _loadPostMetaAsStream() {
    if (_user == null) return;
    _postMetaRepository
        .getMetaAsStream(postId: postId, userId: _user.uId)
        .listen((value) {
      if (value != null) {
        this.postMeta = value;
      }
    }, onError: (onError) {
      debugPrint('Error loading meta: ' + onError.toString());
    });
  }
}
