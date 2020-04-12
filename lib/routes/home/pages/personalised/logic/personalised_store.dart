import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
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
  PersonalisedFeedService _personalisedFeedService;

  _PersonalisedFeedStore(this._personalisedFeedService);

  News newsData;

  @observable
  bool loadingStatus = false;

  @observable
  APIError apiError;

  @observable
  String error;

  @observable
  MenuItem view = MenuItem.LIST_VIEW;

  @action
  fetchFeeds() async {
    try {
      if (null != newsData) return;
      loadingStatus = true;
      newsData = await _personalisedFeedService.getLatestFeeds();
    } on APIError catch (apiError) {
      this.apiError = apiError;
    } on Exception catch (e) {
      this.error = e.toString();
    } finally {
      loadingStatus = false;
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
