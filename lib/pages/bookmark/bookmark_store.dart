import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/common/service/services.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_manager.dart';

part 'bookmark_store.g.dart';

class BookmarkStore = _BookmarkStore with _$BookmarkStore;

abstract class _BookmarkStore with Store {
  final PreferenceService _preferenceService;
  final BookmarkManager _bookmarkManager;

  _BookmarkStore(
    this._preferenceService,
    this._bookmarkManager,
  );

  List<Feed> _feedData = List<Feed>();

  static const int DATA_LIMIT = 20;

  bool _hasMoreData = false;
  bool _isLoadingMore = false;
  StreamController<List<Feed>> _feedStreamController =
      StreamController<List<Feed>>.broadcast();

  Stream<List<Feed>> get feedStream => _feedStreamController.stream;

  @observable
  String error;

  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

  @action
  Future<void> loadInitialData() async {
    _bookmarkManager
        .fetchFeedActivitiesAsStream()
        .where((data) => data != null)
        .listen((onData) {
      _feedData.clear();
      _feedData.addAll(onData);
      _feedStreamController.add(_feedData);
      _hasMoreData = onData.length == DATA_LIMIT;
    }, onError: (e) => _feedStreamController.addError(e));
  }

  @action
  Future<void> loadMoreData({resetPage = false}) async {
    if (_isLoadingMore) return;
    if (!_hasMoreData) return;
    _isLoadingMore = true;
    await _bookmarkManager.fetchFeedActivity().then((feeds) {
      if (feeds != null && feeds.isNotEmpty) {
        _feedData.addAll(feeds);
        _hasMoreData = feeds.length == DATA_LIMIT;
      } else
        _hasMoreData = true;

      _isLoadingMore = false;
    }).catchError((onError) => error = onError.toString());
  }

  @action
  Future<bool> toggleBookmark({@required Feed feed}) async {
    if (await isBookmarkedFeed(feed: feed))
      return removeBookmarkedFeed(feed: feed);
    else
      return addBookmarkedFeed(feed: feed);
  }

  @action
  Future<bool> addBookmarkedFeed({@required Feed feed}) async {
    return await _bookmarkManager
        .addFeedActivity(feedId: feed.uuid, feedData: feed.toJson())
        .then((onValue) => true, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  Future<bool> removeBookmarkedFeed({@required Feed feed}) async {
    return await _bookmarkManager
        .removeFeedActivity(feedId: feed.uuid)
        .then((onValue) => true, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  Future<bool> isBookmarkedFeed({@required Feed feed}) async {
    return await _bookmarkManager
        .doesActivityExist(feedId: feed.uuid)
        .then((onValue) => onValue, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  void retry() {
    _bookmarkManager.resetLastFetchedDocument();
    loadMoreData();
  }

  @action
  Future<void> refresh() async {
    _bookmarkManager.resetLastFetchedDocument();
    return loadMoreData();
  }
}
