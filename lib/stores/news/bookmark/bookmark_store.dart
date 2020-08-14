import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/repository/bookmark_repository.dart';

part 'bookmark_store.g.dart';

class BookmarkStore = _BookmarkStore with _$BookmarkStore;

abstract class _BookmarkStore with Store {
  final BookmarkRepository _bookmarkRepository;
  final UserModel userModel;

  _BookmarkStore(
    this._bookmarkRepository,
    this.userModel,
  );

  List<NewsFeed> _feedData = List<NewsFeed>();

  static const int DATA_LIMIT = 20;

  bool _hasMoreData = false;
  bool _isLoadingMore = false;
  StreamController<List<NewsFeed>> _feedStreamController =
      StreamController<List<NewsFeed>>.broadcast();

  Stream<List<NewsFeed>> get feedStream => _feedStreamController.stream;

  @observable
  String error;

  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

  @action
  Future<void> loadInitialData() async {
    _bookmarkRepository
        .getBookmarksAsStream(userId: userModel.uId)
        .where((data) => data != null)
        .listen((onData) {
      _feedData.clear();
      _feedData.addAll(onData);
      _feedStreamController.add(_feedData);
      _hasMoreData = onData.length == DATA_LIMIT;
    }, onError: (e) {
      print(e.toString());
      _feedStreamController.addError(e);
    });
  }

  @action
  Future<void> loadMoreData({String after}) async {
    if (_isLoadingMore) return;
    if (!_hasMoreData) return;
    _isLoadingMore = true;
    await _bookmarkRepository
        .getBookmarks(userId: userModel.uId, after: after)
        .then((feeds) {
      if (feeds != null && feeds.isNotEmpty) {
        _feedData.addAll(feeds);
        _hasMoreData = feeds.length == DATA_LIMIT;
      } else
        _hasMoreData = false;

      _isLoadingMore = false;
      _feedStreamController.add(_feedData);
    }).catchError((onError) {
      error = onError.toString();
      _isLoadingMore = false;
    });
  }

  @action
  Future _loadFirstPageData() {
    this._feedData.clear();
    return loadMoreData(after: null);
  }

  @action
  Future<bool> addBookmarkedFeed({@required NewsFeed feed}) async {
    return await _bookmarkRepository
        .postBookmark(userId: userModel.uId, feed: feed)
        .then((onValue) => true, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  Future<bool> removeBookmarkedFeed({@required NewsFeed feed}) async {
    return await _bookmarkRepository
        .removeBookmark(postId: feed.uuid, userId: userModel.uId)
        .then((onValue) => true, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  Future<bool> isBookmarkedFeed({@required NewsFeed feed}) async {
    return await _bookmarkRepository
        .doesBookmarkExist(postId: feed.uuid, userId: userModel.uId)
        .then((onValue) => onValue, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  void retry() {
    _loadFirstPageData();
  }

  @action
  Future<void> refresh() async {
    return _loadFirstPageData();
  }

  dispose() {
    _feedStreamController.close();
  }
}
