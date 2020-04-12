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

part 'everything_store.g.dart';

class EverythingStore = _EverythingStore with _$EverythingStore;

abstract class _EverythingStore with Store {
  EverythingService _everythingService;

  _EverythingStore(this._everythingService) {
    fetchFeeds(NewsCategory.tops);
  }

  Map<NewsCategory, News> newsData = Map<NewsCategory, News>();

  @observable
  ObservableMap<NewsCategory, bool> loadingStatus =
      ObservableMap<NewsCategory, bool>();

  @observable
  APIError apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.LIST_VIEW;

  @observable
  int activeTabIndex = 0;

  @action
  fetchFeeds(NewsCategory category) async {
    try {
      if (null != newsData[category]) return;
      loadingStatus[category] = true;
      newsData[category] = await _everythingService.getFeedsByCategory(
        newsCategory: category,
      );
    } on APIError catch (apiError) {
      this.apiError = apiError;
    } on Exception catch (e) {
      this.error = e.toString();
    } finally {
      loadingStatus[category] = false;
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
}
