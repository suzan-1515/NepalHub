import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/auth_service.dart';
import 'package:samachar_hub/common/preference_service.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/routes/article/article_view_screen.dart';
import 'package:samachar_hub/routes/article/logic/article_store.dart';
import 'package:samachar_hub/routes/home/pages/favourites/logic/favourites_service.dart';

part 'favourites_store.g.dart';

class FavouritesStore = _FavouritesStore with _$FavouritesStore;

abstract class _FavouritesStore with Store {
  final FavouritesService _favouritesService;
  final PreferenceService _preferenceService;
  final AuthService _authService;

  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  bool isLoadingMore = false;
  bool hasMoreData = false;

  _FavouritesStore(
      this._preferenceService, this._authService, this._favouritesService);

  List<Feed> feedData = [];
  DocumentSnapshot lastFetchedSnapshot;

  @observable
  ObservableFuture loadFeedItemsFuture;

  @observable
  String error;

  @action
  void loadInitialFeeds() {
    loadFeedItemsFuture = ObservableFuture(_asyncMemoizer.runOnce(() async {
      await _loadFirstPageFeeds();
    }));
  }

  @action
  Future _loadFirstPageFeeds() async {
    feedData.clear();
    try {
      var docList = (await Firestore.instance
              .collection("favourites")
              .document(_authService.userId)
              .collection('news')
              .orderBy('id')
              .limit(20)
              .getDocuments())
          .documents;
      if (docList.isNotEmpty) {
        lastFetchedSnapshot = docList.last;
        hasMoreData = docList.length == 20;
      }

      feedData = docList
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => Feed.fromSnapshot(snapshot.data))
          ?.toList();
    } catch (e) {
      error = e.toString();
      print('Error: ' + error);
    }
  }

  @action
  Future<void> loadMoreData() async {
    try {
      if (isLoadingMore) return;
      isLoadingMore = true;

      var docList = (await Firestore.instance
              .collection("favourites")
              .document(_authService.userId)
              .collection('news')
              .orderBy('id')
              .startAfterDocument(lastFetchedSnapshot)
              .limit(20)
              .getDocuments())
          .documents;

      if (docList.isNotEmpty) {
        lastFetchedSnapshot = docList.last;
        hasMoreData = docList.length == 20;
      }

      feedData.addAll(docList
          .where((snapshot) => snapshot != null && snapshot.exists)
          .map((snapshot) => Feed.fromSnapshot(snapshot.data))
          ?.toList());
    } catch (e) {
      error = e.toString();
    } finally {
      isLoadingMore = false;
    }
  }

  @action
  Future<bool> addFavouriteFeed({@required Feed feed}) async {
    await Firestore.instance
        .collection("favourites")
        .document(_authService.userId)
        .collection('news')
        .document()
        .setData(feed.toJson())
        .catchError((e) => error = e.toString());

    return Future.value(true);
  }

  @action
  void retry() {
    _loadFirstPageFeeds();
  }

  @action
  Future<void> refresh() async {
    return _loadFirstPageFeeds();
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
