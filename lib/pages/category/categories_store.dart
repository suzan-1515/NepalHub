import 'package:async/async.dart';
import 'package:mobx/mobx.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/category/categories_page.dart';
import 'package:samachar_hub/repository/news_repository.dart';
import 'package:throttling/throttling.dart';

part 'categories_store.g.dart';

class CategoriesStore = _CategoriesStore with _$CategoriesStore;

abstract class _CategoriesStore with Store {
  final NewsRepository _newsRepository;
  final Map<NewsCategory, AsyncMemoizer> _asyncMemoizer =
      Map<NewsCategory, AsyncMemoizer>();
  final Map<NewsCategory, bool> isLoadingMore = Map<NewsCategory, bool>();
  final Map<NewsCategory, Throttling> _throttling =
      Map<NewsCategory, Throttling>();

  _CategoriesStore(this._newsRepository);

  @observable
  ObservableMap<NewsCategory, ObservableFuture> loadFeedItemsFuture =
      ObservableMap<NewsCategory, ObservableFuture>();

  Map<NewsCategory, List<NewsFeedModel>> newsData = Map<NewsCategory, List<NewsFeedModel>>();

  Map<NewsCategory, bool> hasMoreData = Map<NewsCategory, bool>();

  @observable
  String error;

  @observable
  APIException apiError;

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

      List<NewsFeedModel> cachedNews = newsData[category];
      if (cachedNews == null || cachedNews.isEmpty) {
        List<NewsFeedModel> moreNews =
            await _newsRepository.getFeedsByCategory(category: category);
        if (moreNews != null) {
          if (moreNews.isNotEmpty) {
            newsData[category] = moreNews;
            hasMoreData[category] = true;
          } else
            hasMoreData[category] = false;
        }
      } else {
        List<NewsFeedModel> moreNews = await _newsRepository.getFeedsByCategory(
            category: category, lastFeedId: cachedNews.last.id);
        if (moreNews != null) {
          if (moreNews.isNotEmpty) {
            cachedNews.addAll(moreNews);
            hasMoreData[category] = true;
          } else
            hasMoreData[category] = false;
        }
      }
    } on APIException catch (apiError) {
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

  dispose() {
    _throttling.forEach((key, value) => value.dispose());
    _throttling.clear();
    _asyncMemoizer.clear();
    isLoadingMore.clear();
    loadFeedItemsFuture.clear();
    newsData.clear();
    hasMoreData.clear();
  }
}
