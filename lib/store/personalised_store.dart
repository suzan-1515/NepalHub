import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/dto/feed_dto.dart';
import 'package:samachar_hub/routes/home/pages/pages.dart';
import 'package:samachar_hub/routes/routes.dart';
import 'package:samachar_hub/service/personalised_service.dart';
import 'package:samachar_hub/service/preference_service.dart';
import 'package:samachar_hub/store/article_store.dart';

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

  List<Feed> newsData = List<Feed>();

  @observable
  ObservableFuture loadFeedItemsFuture;

  @observable
  APIException apiError;

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
    newsData.clear();
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

      List<Feed> moreNews = await _personalisedFeedService.getLatestFeeds();
      if (moreNews != null) {
        newsData.addAll(moreNews);
      }
    } on APIException catch (apiError) {
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
