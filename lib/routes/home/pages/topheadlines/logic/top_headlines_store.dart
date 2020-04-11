import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api.dart';
import 'package:samachar_hub/data/model/api_error.dart';
import 'package:samachar_hub/data/model/article.dart';
import 'package:samachar_hub/data/model/top_headlines.dart';
import 'package:samachar_hub/routes/article/article_view_screen.dart';
import 'package:samachar_hub/routes/article/logic/article_store.dart';
import 'package:samachar_hub/routes/home/pages/topheadlines/logic/top_headlines_service.dart';
import 'package:samachar_hub/routes/home/pages/topheadlines/top_headlines_page.dart';

part 'top_headlines_store.g.dart';

class TopHeadlinesStore = _TopHeadlinesStore with _$TopHeadlinesStore;

abstract class _TopHeadlinesStore with Store {
  TopHeadlinesService _topHeadlinesService;

  _TopHeadlinesStore(this._topHeadlinesService) {
    fetchTopHeadlines(NewsCategory.general);
  }

  Map<NewsCategory, TopHeadlines> newsData = Map<NewsCategory, TopHeadlines>();

  @observable
  ObservableMap<NewsCategory, bool> loadingStatus = ObservableMap<NewsCategory,bool>();

  @observable
  APIError apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.LIST_VIEW;

  @observable
  int activeTabIndex = 0;

  @action
  fetchTopHeadlines(NewsCategory category) async {
    try {
      if (null != newsData[category]) return;
      loadingStatus[category] = true;
      newsData[category] = await _topHeadlinesService.getTopHeadlines(
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
  onArticleClick(Article article, BuildContext context) {
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
