import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/comment_model.dart';
import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/pages/comment/comment_repository.dart';

part 'comment_store.g.dart';

class CommentStore = _CommentStore with _$CommentStore;

abstract class _CommentStore with Store {
  final CommentRepository _commentRepository;
  final UserModel _user;
  _CommentStore(
      {@required CommentRepository commentRepository, @required UserModel user})
      : this._commentRepository = commentRepository,
        this._user = user;

  StreamController<List<CommentModel>> _dataStreamController =
      StreamController<List<CommentModel>>.broadcast();

  Stream<List<CommentModel>> get dataStream => _dataStreamController.stream;

  List<CommentModel> data = List<CommentModel>();
  bool hasMoreData = false;
  bool isLoadingMore = false;

  @observable
  String postId = '';

  @observable
  String postTitle = '';

  @observable
  APIException apiError;

  @observable
  String error;

  @action
  setPostId(String postId) {
    this.postId = postId;
  }

  @action
  setPostTitle(String postTitle) {
    this.postTitle = postTitle;
  }

  @action
  void retry() {
    _loadFirstPageData();
  }

  @action
  Future<void> refresh() async {
    return _loadFirstPageData();
  }

  @action
  Future<void> submitComment({@required String comment}) {
    return _commentRepository
        .postComment(postId: postId, user: _user, comment: comment)
        .catchError((onError) {
      this.error = 'Error posting comment. Try again later..';
    });
  }

  @action
  loadData() {
    _loadFirstPageData();
  }

  @action
  Future _loadFirstPageData() async {
    data.clear();
    await loadMoreData(after: null);
  }

  @action
  Future loadMoreData({@required CommentModel after}) async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    return await _commentRepository
        .getComments(postId: postId, after: after?.timestamp)
        .then((value) {
      isLoadingMore = false;
      if (value == null || value.isEmpty) {
        hasMoreData = false;
        _dataStreamController.add(data);
        return;
      }

      data.addAll(value);
      hasMoreData = value.length == CommentRepository.DATA_LIMIT;

      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
      isLoadingMore = false;
      _dataStreamController.addError(error);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
      isLoadingMore = false;
      _dataStreamController.addError(error);
    });
  }

  dispose() {
    _dataStreamController.close();
    data.clear();
  }
}
