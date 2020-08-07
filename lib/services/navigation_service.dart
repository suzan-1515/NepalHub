import 'package:corona_module/corona.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/authentication/login/login_screen.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_page.dart';
import 'package:samachar_hub/pages/comment/comment_screen.dart';
import 'package:samachar_hub/pages/forex/forex_detail_screen.dart';
import 'package:samachar_hub/pages/forex/forex_screen.dart';
import 'package:samachar_hub/pages/home/home_screen.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_detail_screen.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_screen.dart';
import 'package:samachar_hub/pages/main/main_screen.dart';
import 'package:samachar_hub/pages/news/category/categories_screen.dart';
import 'package:samachar_hub/pages/news/category/news_category_feed_screen.dart';
import 'package:samachar_hub/pages/news/details/news_detail_screen.dart';
import 'package:samachar_hub/pages/news/source/news_source_feed_screen.dart';
import 'package:samachar_hub/pages/news/source/sources_screen.dart';
import 'package:samachar_hub/pages/news/topics/news_topic_feed_screen.dart';
import 'package:samachar_hub/pages/news/trending/trending_news_screen.dart';
import 'package:samachar_hub/pages/settings/settings_page.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/webview_widget.dart';

class NavigationService {
  toHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  toTrendingNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProxyProvider<NewsRepository, TrendingNewsStore>(
          update: (_, NewsRepository value, TrendingNewsStore previous) =>
              TrendingNewsStore(value),
          dispose: (context, value) => value.dispose(),
          child: TrendingNewsScreen(),
        ),
      ),
    );
  }

  toCoronaScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoronaApp(),
      ),
    );
  }

  toForexScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProxyProvider2<ForexRepository, PreferenceService, ForexStore>(
          update: (_, ForexRepository value,
                  PreferenceService _preferenceService, ForexStore previous) =>
              ForexStore(value, _preferenceService),
          dispose: (context, value) => value.dispose(),
          child: ForexScreen(),
        ),
      ),
    );
  }

  toForexDetailScreen(BuildContext context, ForexModel data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ProxyProvider2<PostMetaRepository, AuthenticationStore,
                PostMetaStore>(
              update: (_,
                      PostMetaRepository metaRepository,
                      AuthenticationStore authenticationStore,
                      PostMetaStore previous) =>
                  PostMetaStore(
                      metaRepository, authenticationStore.user, 'forex'),
            ),
            ProxyProvider<ForexRepository, ForexDetailStore>(
              update: (_, ForexRepository value, ForexDetailStore previous) =>
                  ForexDetailStore(value, data),
              dispose: (context, value) => value.dispose(),
            ),
          ],
          child: ForexDetailScreen(),
        ),
      ),
    );
  }

  toHoroscopeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProxyProvider2<HoroscopeRepository,
            PreferenceService, HoroscopeStore>(
          update: (_,
                  HoroscopeRepository value,
                  PreferenceService _preferenceService,
                  HoroscopeStore previous) =>
              HoroscopeStore(value, _preferenceService),
          dispose: (context, value) => value.dispose(),
          child: HoroscopeScreen(),
        ),
      ),
    );
  }

  toHoroscopeDetail(BuildContext context, String sign, String signIcon,
      String zodiac, HoroscopeModel data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ProxyProvider2<PostMetaRepository, AuthenticationStore,
                PostMetaStore>(
              update: (_,
                      PostMetaRepository metaRepository,
                      AuthenticationStore authenticationStore,
                      PostMetaStore previous) =>
                  PostMetaStore(
                      metaRepository, authenticationStore.user, 'horoscope'),
            ),
            Provider<HoroscopeDetailStore>(
              create: (_) => HoroscopeDetailStore(data),
              dispose: (context, value) => value.dispose(),
            ),
          ],
          child: HoroscopeDetailScreen(
              sign: sign, signIcon: signIcon, zodiac: zodiac),
        ),
      ),
    );
  }

  toGoldSilverScreen(BuildContext context) {}

  toFeedDetail(NewsFeed article, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ProxyProvider2<PostMetaRepository, AuthenticationStore,
                PostMetaStore>(
              update: (BuildContext context,
                      PostMetaRepository metaRepository,
                      AuthenticationStore authenticationStore,
                      PostMetaStore previous) =>
                  PostMetaStore(
                      metaRepository, authenticationStore.user, article.uuid),
            ),
            ProxyProvider3<ShareService, AuthenticationStore,
                BookmarkRepository, NewsDetailStore>(
              update: (BuildContext context,
                      ShareService shareService,
                      AuthenticationStore authenticationStore,
                      BookmarkRepository bookmarkRepository,
                      NewsDetailStore previous) =>
                  NewsDetailStore(shareService, authenticationStore.user,
                      bookmarkRepository, article),
              dispose: (context, value) => value.dispose(),
            ),
          ],
          child: NewsDetailScreen(feed: article),
        ),
      ),
    );
  }

  Future toFavouriteNewsSourceScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            Provider.value(value: Provider.of<FollowingRepository>(context)),
            ProxyProvider2<NewsRepository, FollowingRepository,
                    NewsSourceStore>(
                update: (BuildContext context,
                        NewsRepository value,
                        FollowingRepository favouritesRepository,
                        NewsSourceStore previous) =>
                    NewsSourceStore(value, favouritesRepository),
                dispose: (context, value) => value.dispose()),
          ],
          child: NewsSourcesScreen(),
        ),
      ),
    );
  }

  Future toNewsCategoryFeedScreen(
      BuildContext context, NewsCategory NewsCategory) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProxyProvider<NewsRepository, NewsCategoryFeedStore>(
            update: (_, NewsRepository value, NewsCategoryFeedStore previous) =>
                NewsCategoryFeedStore(value, NewsCategory),
            dispose: (context, value) => value.dispose(),
            child: NewsCategoryFeedScreen(),
          ),
        ));
  }

  Future toFavouriteNewsCategoryScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiProvider(
          providers: [
            Provider.value(value: Provider.of<FollowingRepository>(context)),
            ProxyProvider2<NewsRepository, FollowingRepository,
                    NewsCategoriesStore>(
                update: (BuildContext context,
                        NewsRepository value,
                        FollowingRepository favouritesRepository,
                        NewsCategoriesStore previous) =>
                    NewsCategoriesStore(value, favouritesRepository),
                dispose: (context, value) => value.dispose()),
            // Provider.value(value: Provider.of<FollowingStore>(context)),
            // Provider.value(value: Provider.of<FollowingRepository>(context)),
          ],
          child: NewsCategoriesScreen(),
        ),
      ),
    );
  }

  toWebViewScreen(String title, String url, BuildContext context) {
    print('open link: $title');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Webview(
          title: title,
          url: url,
        ),
      ),
    );
  }

  Future toNewsTopicFeedScreen(
      {@required BuildContext context, @required NewsTopic topicModel}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProxyProvider<NewsRepository, NewsTopicFeedStore>(
          update: (_, NewsRepository value, NewsTopicFeedStore previous) =>
              NewsTopicFeedStore(value, topicModel),
          dispose: (context, value) => value.dispose(),
          child: NewsTopicFeedScreen(),
        ),
      ),
    );
  }

  Future toNewsSourceFeedScreen(
      {@required NewsSource source,
      @required List<NewsSource> sources,
      @required BuildContext context}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProxyProvider<NewsRepository, NewsSourceFeedStore>(
            update:
                (_, NewsRepository newsRepository, NewsSourceFeedStore store) =>
                    NewsSourceFeedStore(newsRepository, source),
            dispose: (context, value) => value.dispose(),
            child: NewsSourceFeedScreen(),
          ),
        ));
  }

  toCommentsScreen(
      {@required BuildContext context,
      @required String title,
      @required String postId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ProxyProvider2<PostMetaRepository, AuthenticationStore,
                PostMetaStore>(
              update: (BuildContext context,
                      PostMetaRepository metaRepository,
                      AuthenticationStore authenticationStore,
                      PostMetaStore previous) =>
                  PostMetaStore(
                      metaRepository, authenticationStore.user, postId),
            ),
            ProxyProvider2<AnalyticsService, PostMetaRepository,
                CommentRepository>(
              update: (BuildContext context,
                      AnalyticsService analyticsService,
                      PostMetaRepository postMetaRepository,
                      CommentRepository previous) =>
                  CommentRepository(
                CommentFirestoreService(),
                postMetaRepository,
                analyticsService,
              ),
            ),
            ProxyProvider2<CommentRepository, AuthenticationStore,
                CommentStore>(
              update: (BuildContext context,
                      CommentRepository commentRepository,
                      AuthenticationStore authenticationStore,
                      CommentStore previous) =>
                  CommentStore(
                      commentRepository: commentRepository,
                      user: authenticationStore.user),
              dispose: (context, value) => value.dispose(),
            ),
          ],
          child: CommentScreen(
            postTitle: title,
            postId: postId,
          ),
        ),
      ),
    );
  }

  loginRedirect(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  Future toSettingsScreen({@required BuildContext context}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsPage(),
      ),
    );
  }

  Future toUserProfileScreen({@required BuildContext context}) {}

  Future toBookmarkedNewsScreen({@required BuildContext context}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProxyProvider2<BookmarkRepository, AuthenticationStore,
            BookmarkStore>(
          update: (_, _bookmarkRepository, _authenticationStore, __) =>
              BookmarkStore(_bookmarkRepository, _authenticationStore.user),
          child: BookmarkScreen(),
        ),
      ),
    );
  }
}
