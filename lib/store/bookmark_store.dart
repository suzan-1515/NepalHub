import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/manager/bookmark_manager.dart';
import 'package:samachar_hub/routes/article/article_view_screen.dart';
import 'package:samachar_hub/service/preference_service.dart';
import 'package:samachar_hub/store/article_store.dart';

part 'bookmark_store.g.dart';

class BookmarkStore = _BookmarkStore with _$BookmarkStore;

abstract class _BookmarkStore with Store {
  final PreferenceService _preferenceService;
  final BookmarkManager _bookmarkManager;

  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  _BookmarkStore(
    this._preferenceService,
    this._bookmarkManager,
  );

  List<Feed> _feedData = List<Feed>();

  static const int DATA_LIMIT = 20;

  bool _hasMoreData = true;
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
        .fetchBookmarksAsStream()
        .where((data) => data != null && data.isNotEmpty)
        .listen((onData) {
      _feedData.clear();
      _feedData.addAll(onData);
      _feedStreamController.add(_feedData);
    }, onError: (e) => _feedStreamController.addError(e));
  }

  @action
  Future<void> loadMoreData({resetPage = false}) async {
    if (_isLoadingMore) return;
    if (!_hasMoreData) return;
_isLoadingMore = true;
    await _bookmarkManager.fetchBookmarks(resetPage: resetPage).then((feeds) {
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
    if (isBookmarked(feed: feed))
      return removeBookmarkedFeed(feed: feed);
    else
      return addBookmarkedFeed(feed: feed);
  }

  @action
  Future<bool> addBookmarkedFeed({@required Feed feed}) async {
    return await _bookmarkManager
        .addBookmarkedFeed(id: feed.uuid, data: feed.toJson())
        .then((onValue) => true, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  @action
  Future<bool> removeBookmarkedFeed({@required Feed feed}) async {
    return await _bookmarkManager
        .removeBookmarkedFeed(feedId: feed.uuid)
        .then((onValue) => true, onError: (e) {
      error = e.toString();
      return false;
    });
  }

  bool isBookmarked({@required Feed feed}) =>
      _feedData.where((test) => test.uuid == feed.uuid).isNotEmpty;

  @action
  void retry() {
    loadMoreData(resetPage: true);
  }

  @action
  Future<void> refresh() async {
    return loadMoreData();
  }

  onFeedClick(Feed article, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Provider<ArticleStore>(
          create: (_) => ArticleStore(article),
          child: Consumer<ArticleStore>(
            builder: (context, store, _) => ArticleViewScreen(store),
          ),
        ),
      ),
    );
  }
}
