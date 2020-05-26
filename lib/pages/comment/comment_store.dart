import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/manager/managers.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/comment_model.dart';
import 'package:samachar_hub/pages/comment/comment_repository.dart';
import 'package:uuid/uuid.dart';

part 'comment_store.g.dart';

class CommentStore = _CommentStore with _$CommentStore;

abstract class _CommentStore with Store {
  final CommentRepository _commentRepository;
  final AuthenticationController _authenticationManager;
  _CommentStore(
      {@required CommentRepository commentRepository,
      @required AuthenticationController authenticationManager})
      : this._commentRepository = commentRepository,
        this._authenticationManager = authenticationManager;

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
  int likesCount = 0;

  @observable
  int commentsCount = 0;

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
  setLikesCount(int count) {
    this.likesCount = count;
  }

  @action
  setCommentsCount(int count) {
    this.commentsCount = count;
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
  Future<CommentModel> submitComment({@required String comment}) {
    return _commentRepository
        .postComment(
      postId: postId,
      commentModel: CommentModel(
          Uuid().v4(),
          _authenticationManager.currentUser,
          comment,
          0,
          DateTime.now().toString()),
    )
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
    isLoadingMore = true;
    return await _commentRepository
        .getComments(postId: postId, after: after?.timestamp)
        .then((value) {
      isLoadingMore = false;
      if (value == null) {
        hasMoreData = false;
        _dataStreamController.add(data);
        return;
      }
      setLikesCount(value.likesCount);
      setCommentsCount(value.totalCount);
      if (value.comments != null && value.comments.isNotEmpty) {
        data.addAll(value.comments);
        hasMoreData = value.comments.length == CommentRepository.DATA_LIMIT;
      } else {
        hasMoreData = false;
      }
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
