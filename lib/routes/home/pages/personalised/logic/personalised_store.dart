import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/preference_service.dart';
import 'package:samachar_hub/data/model/api_error.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/data/model/news.dart';
import 'package:samachar_hub/routes/article/article_view_screen.dart';
import 'package:samachar_hub/routes/article/logic/article_store.dart';
import 'package:samachar_hub/routes/home/pages/pages.dart';
import 'package:samachar_hub/routes/home/pages/personalised/logic/personalised_service.dart';

part 'personalised_store.g.dart';

class PersonalisedFeedStore = _PersonalisedFeedStore
    with _$PersonalisedFeedStore;

abstract class _PersonalisedFeedStore with Store {
  final PersonalisedFeedService _personalisedFeedService;
  final PreferenceService _preferenceService;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  bool isLoadingMore = false;
  bool hasMoreData = false;

  _PersonalisedFeedStore(
      this._preferenceService, this._personalisedFeedService);

  News newsData;

  @observable
  ObservableFuture loadFeedItemsFuture;

  @observable
  APIError apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.THUMBNAIL_VIEW;

  @action
  void loadInitialFeeds() {
    loadFeedItemsFuture = ObservableFuture(_asyncMemoizer.runOnce(() async {
      await _loadFirstPageFeeds();
    }));
  }

  @action
  Future<void> _loadFirstPageFeeds() async {
    newsData = null;
    await loadMoreData();
  }

  @action
  Future<void> refresh() async {
    return _loadFirstPageFeeds();
  }

  @action
  void retry() {
    loadFeedItemsFuture = ObservableFuture(_loadFirstPageFeeds());
  }

  @action
  Future<void> loadMoreData() async {
    try {
      if (isLoadingMore) return;
      isLoadingMore = true;

      News moreNews = await _personalisedFeedService.getLatestFeeds();
      if (moreNews != null) {
        newsData = moreNews;
      }
    } on APIError catch (apiError) {
      this.apiError = apiError;
    } on Exception catch (e) {
      this.error = e.toString();
    } finally {
      isLoadingMore = false;
    }
  }

  @action
  setView(MenuItem value) {
    view = value;
  }

  // Todo: Use proper named navigation. Should navigation be done here?
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
