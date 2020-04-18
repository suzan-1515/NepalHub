import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api.dart';
import 'package:samachar_hub/data/model/api_error.dart';
import 'package:samachar_hub/data/model/feed.dart';
import 'package:samachar_hub/data/model/news.dart';
import 'package:samachar_hub/routes/article/article_view_screen.dart';
import 'package:samachar_hub/routes/article/logic/article_store.dart';
import 'package:samachar_hub/routes/home/pages/everything/logic/everything_service.dart';
import 'package:samachar_hub/routes/home/pages/pages.dart';
import 'package:throttling/throttling.dart';

part 'everything_store.g.dart';

class EverythingStore = _EverythingStore with _$EverythingStore;

abstract class _EverythingStore with Store {
  final EverythingService _everythingService;
  final Map<NewsCategory, AsyncMemoizer> _asyncMemoizer =
      Map<NewsCategory, AsyncMemoizer>();
  final Map<NewsCategory, bool> isLoadingMore = Map<NewsCategory, bool>();
  final Map<NewsCategory, Throttling> _throttling =
      Map<NewsCategory, Throttling>();

  _EverythingStore(this._everythingService) {
    loadInitialFeeds(NewsCategory.tops);
  }

  @observable
  ObservableMap<NewsCategory, ObservableFuture> loadFeedItemsFuture =
      ObservableMap<NewsCategory, ObservableFuture>();

  Map<NewsCategory, News> newsData = Map<NewsCategory, News>();

  Map<NewsCategory, bool> hasMoreData = Map<NewsCategory, bool>();

  @observable
  APIError apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.LIST_VIEW;

  @observable
  int activeTabIndex = 0;

  @action
  void loadInitialFeeds(NewsCategory category) {
    if (!_throttling.containsKey(category))
      _throttling[category] = Throttling(duration: Duration(minutes: 1));

    _throttling[category].throttle(() {
      if (!_asyncMemoizer.containsKey(category))
        _asyncMemoizer[category] = AsyncMemoizer();
      loadFeedItemsFuture[category] =
          ObservableFuture(_asyncMemoizer[category].runOnce(() async {
        await _loadFirstPageFeeds(category);
      }));
    });
  }

  @action
  Future<void> _loadFirstPageFeeds(NewsCategory category) async {
    newsData.remove(category);
    await loadMoreData(category);
  }

  @action
  Future<void> refresh(NewsCategory category) async {
    return _loadFirstPageFeeds(category);
  }

  @action
  void retry(NewsCategory category) {
    loadFeedItemsFuture[category] =
        ObservableFuture(_loadFirstPageFeeds(category));
  }

  @action
  Future<void> loadMoreData(NewsCategory category) async {
    try {
      if (isLoadingMore[category] ?? false) return;
      isLoadingMore[category] = true;

      News cachedNews = newsData[category];
      if (cachedNews == null ||
          cachedNews.feeds == null ||
          cachedNews.feeds.isEmpty) {
        News moreNews =
            await _everythingService.getFeedsByCategory(newsCategory: category);
        if (moreNews != null) {
          if (moreNews.feeds != null && moreNews.feeds.isNotEmpty) {
            newsData[category] = moreNews;
            hasMoreData[category] = true;
          } else
            hasMoreData[category] = false;
        }
      } else {
        News moreNews = await _everythingService.getFeedsByCategory(
            newsCategory: category, lastFeedId: cachedNews.feeds.last.id);
        if (moreNews != null) {
          if (moreNews.feeds != null && moreNews.feeds.isNotEmpty) {
            cachedNews.feeds.addAll(moreNews.feeds);
            hasMoreData[category] = true;
          } else
            hasMoreData[category] = false;
        }
      }
    } on APIError catch (apiError) {
      this.apiError = apiError;
    } on Exception catch (e) {
      this.error = e.toString();
    } finally {
      isLoadingMore[category] = false;
    }
  }

  @action
  setView(MenuItem value) {
    view = value;
  }

  @action
  setActiveTab(int value) {
    activeTabIndex = value;
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

  dispose() {
    _throttling.forEach((key,value)=> value.dispose());
    _throttling.clear();
    _asyncMemoizer.clear();
    isLoadingMore.clear();
    loadFeedItemsFuture.clear();
    newsData.clear();
    hasMoreData.clear();
  }
}
