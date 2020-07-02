import 'package:corona_module/corona.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/authentication/login/login_screen.dart';
import 'package:samachar_hub/pages/bookmark/bookmark_repository.dart';
import 'package:samachar_hub/pages/category/categories_store.dart';
import 'package:samachar_hub/pages/comment/comment_firestore_service.dart';
import 'package:samachar_hub/pages/comment/comment_repository.dart';
import 'package:samachar_hub/pages/comment/comment_screen.dart';
import 'package:samachar_hub/pages/comment/comment_store.dart';
import 'package:samachar_hub/pages/favourites/news/categories_screen.dart';
import 'package:samachar_hub/pages/favourites/news/category_selection_screen.dart';
import 'package:samachar_hub/pages/favourites/news/category_store.dart';
import 'package:samachar_hub/pages/favourites/news/source_selection_screen.dart';
import 'package:samachar_hub/pages/favourites/news/source_store.dart';
import 'package:samachar_hub/pages/favourites/news/sources_screen.dart';
import 'package:samachar_hub/pages/forex/forex_detail_store.dart';
import 'package:samachar_hub/pages/forex/forex_repository.dart';
import 'package:samachar_hub/pages/forex/forex_screen.dart';
import 'package:samachar_hub/pages/forex/forex_detail_screen.dart';
import 'package:samachar_hub/pages/forex/forex_store.dart';
import 'package:samachar_hub/pages/home/home_screen.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_detail_screen.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_detail_store.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_repository.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_screen.dart';
import 'package:samachar_hub/pages/horoscope/horoscope_store.dart';
import 'package:samachar_hub/pages/news/details/news_details.dart';
import 'package:samachar_hub/pages/news/news_repository.dart';
import 'package:samachar_hub/pages/news/sources/news_source_screen.dart';
import 'package:samachar_hub/pages/news/sources/news_source_store.dart';
import 'package:samachar_hub/pages/news/topics/news_topic_screen.dart';
import 'package:samachar_hub/pages/news/topics/news_topic_store.dart';
import 'package:samachar_hub/pages/news/trending/trending_news_screen.dart';
import 'package:samachar_hub/pages/news/trending/trending_news_store.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/webview_widget.dart';

class NavigationService {
  toHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProxyProvider<CoronaRepository, CoronaStore>(
    //       update: (_, CoronaRepository value, CoronaStore previous) =>
    //           CoronaStore(value),
    //       dispose: (context, value) => value.dispose(),
    //       child: CoronaScreen(),
    //     ),
    //   ),
    // );
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

  toFeedDetail(NewsFeedModel article, BuildContext context) {
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

  toNewsSourceFeedScreen(BuildContext context, NewsSourceModel sourceModel) {
    debugPrint('to news source feeds screen');
  }

  toFavouriteNewsSourceScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProxyProvider<NewsRepository, FavouriteNewsSourceStore>(
          update: (BuildContext context, NewsRepository value,
                  FavouriteNewsSourceStore previous) =>
              FavouriteNewsSourceStore(value),
          dispose: (context, value) => value.dispose(),
          child: FavouriteNewsSourceScreen(),
        ),
      ),
    );
  }

  toNewsCategoryScreen(
      BuildContext context, NewsCategoryModel newsCategoryModel) {
    Provider.of<HomeScreenStore>(context, listen: false).setPage(1);
    Provider.of<CategoriesStore>(context, listen: false)
        .setActiveTab(newsCategoryModel.index);
  }

  toFavouriteNewsCategoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProxyProvider<NewsRepository, FavouriteNewsCategoryStore>(
          update: (BuildContext context, NewsRepository value,
                  FavouriteNewsCategoryStore previous) =>
              FavouriteNewsCategoryStore(value),
          dispose: (context, value) => value.dispose(),
          child: FavouriteNewsCategoryScreen(),
        ),
      ),
    );
  }

  toNewsCategorySelectionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsCategorySelectionScreen(),
      ),
    );
  }

  onOpenLink(String title, String url, BuildContext context) {
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

  onNewsCategoryMenuTapped(
      {@required NewsCategoryMenuModel category,
      @required BuildContext context}) {
    Provider.of<HomeScreenStore>(context, listen: false).setPage(1);
    Provider.of<CategoriesStore>(context, listen: false)
        .setActiveTab(category.index);
  }

  toNewsTopicScreen({@required String title, @required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProxyProvider<NewsRepository, NewsTopicStore>(
          update: (BuildContext context, NewsRepository value,
                  NewsTopicStore previous) =>
              NewsTopicStore(value),
          dispose: (context, value) => value.dispose(),
          child: NewsTopicScreen(
            topic: title,
          ),
        ),
      ),
    );
  }

  onNewsSourceMenuTapped(
      {@required NewsSourceModel source, @required BuildContext context}) {
    print('Tag selected: $source.name');
  }

  toNewsSourceSelectionScreen({@required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProxyProvider<NewsRepository, FavouriteNewsSourceStore>(
          update: (BuildContext context, NewsRepository value,
                  FavouriteNewsSourceStore previous) =>
              FavouriteNewsSourceStore(value),
          dispose: (context, value) => value.dispose(),
          child: NewsSourceSelectionScreen(),
        ),
      ),
    );
  }

  onViewCommentsTapped(
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
}
