import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/comment_model.dart';
import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/repository/comment_repository.dart';

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
  bool _hasMoreData = false;
  bool _isLoadingMore = false;
  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

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
  Future<bool> likeComment({@required CommentModel comment}) {
    return _commentRepository
        .postCommentLike(
      postId: postId,
      userId: _user.uId,
      commentId: comment.id,
    )
        .then((value) {
      return true;
    }).catchError((onError) {
      this.error = 'Unable to like comment.';
      comment.like = false;
      return false;
    });
  }

  @action
  Future<bool> unlikeComment({@required CommentModel comment}) {
    return _commentRepository
        .postCommentUnlike(
      postId: postId,
      commentId: comment.id,
      userId: _user.uId,
    )
        .then((value) {
      return true;
    }).catchError((onError) {
      this.error = 'Unable to unlike comment.';
      comment.like = true;
      return false;
    });
  }

  @action
  Future _loadFirstPageData() {
    this.data.clear();
    return loadMoreData(after: null);
  }

  @action
  Future<void> loadInitialData() async {
    _commentRepository
        .getCommentsAsStream(postId: postId, userId: _user.uId)
        .where((data) => data != null)
        .listen((onData) {
      data.clear();
      data.addAll(onData);
      _dataStreamController.sink.add(data);
      _hasMoreData = onData.length == CommentRepository.DATA_LIMIT;
    }, onError: (e) {
      log(e.toString());
      this.error = e.toString();
      _dataStreamController.addError(e);
    });
  }

  @action
  Future loadMoreData({@required CommentModel after}) async {
    if (isLoadingMore || !hasMoreData) return;
    _isLoadingMore = true;
    return await _commentRepository
        .getComments(postId: postId, userId: _user.uId, after: after?.timestamp)
        .then((value) {
      _isLoadingMore = false;
      if (value != null && value.isNotEmpty) {
        data.addAll(value);
        _hasMoreData = value.length == CommentRepository.DATA_LIMIT;
      } else {
        _hasMoreData = false;
      }

      _dataStreamController.add(data);
    }).catchError((onError) {
      this.apiError = onError;
      _isLoadingMore = false;
      _dataStreamController.addError(error);
    }, test: (e) => e is APIException).catchError((onError) {
      this.error = onError.toString();
      _isLoadingMore = false;
      _dataStreamController.addError(error);
    });
  }

  dispose() {
    _dataStreamController.close();
    data.clear();
  }
}
