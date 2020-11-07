import 'package:corona_module/corona.dart';
import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/login_screen.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/details/gold_silver_detail_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/gold_silver_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/models/horoscope_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/main/main_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/settings_page.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_topic_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/bookmark/bookmark_page.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/news_categories_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/news_category_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/latest/latest_news_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/news_source_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/sources_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/news_topic_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/topics_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/trending/trending_news_screen.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/comment_screen.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail/forex_detail_screen.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/forex_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/detail/horoscope_detail_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope/horoscope_screen.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/user_profile_screen.dart';
import 'package:samachar_hub/core/widgets/webview_widget.dart';

class NavigationService {
  Future toHomeScreen(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future toLoginScreen(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future toTrendingNews(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrendingNewsScreen(),
      ),
    );
  }

  Future toLatestNewsScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LatestNewsScreen(),
      ),
    );
  }

  Future toCoronaScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoronaApp(),
      ),
    );
  }

  Future toForexScreen(BuildContext context) {
    return ForexScreen.navigate(context);
  }

  Future toForexDetailScreen(BuildContext context, ForexUIModel data) {
    return ForexDetailScreen.navigate(context: context, forexUIModel: data);
  }

  Future toHoroscopeScreen(BuildContext context) {
    return HoroscopeScreen.navigate(context: context);
  }

  Future toHoroscopeDetail(
      BuildContext context, int signIndex, HoroscopeUIModel horoscopeUIModel) {
    return HoroscopeDetailScreen.navigate(
        context: context,
        horoscopeUIModel: horoscopeUIModel,
        signIndex: signIndex);
  }

  Future toGoldSilverScreen(BuildContext context) {
    return GoldSilverScreen.navigate(context);
  }

  Future toFollowedNewsSourceScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsSourcesScreen(),
      ),
    );
  }

  Future toFollowedNewsTopicScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsTopicsScreen(),
      ),
    );
  }

  Future toNewsCategoryFeedScreen(
      BuildContext context, NewsCategoryEntity categoryEntity) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsCategoryFeedScreen(
            newsCategoryEntity: categoryEntity,
          ),
        ));
  }

  Future toFollowedNewsCategoryScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsCategoriesScreen(),
      ),
    );
  }

  Future toWebViewScreen(String title, String url, BuildContext context) {
    return Navigator.push(
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
      {@required BuildContext context, @required NewsTopicEntity topic}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsTopicFeedScreen(
          newsTopicEntity: topic,
        ),
      ),
    );
  }

  Future toNewsSourceFeedScreen(
      {@required NewsSourceEntity source, @required BuildContext context}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsSourceFeedScreen(
            newsSourceEntity: source,
          ),
        ));
  }

  Future toCommentsScreen(
      {@required BuildContext context,
      @required String threadTitle,
      @required CommentThreadType threadType,
      @required String threadId}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(
          threadId: threadId,
          threadTitle: threadTitle,
          threadType: threadType,
        ),
      ),
    );
  }

  Future loginRedirect(BuildContext context) {
    return Navigator.push(
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
        builder: (_) => SettingsScreen(),
      ),
    );
  }

  Future toUserProfileScreen({@required BuildContext context}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserProfileScreen(),
      ),
    );
  }

  Future toBookmarkedNewsScreen({@required BuildContext context}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookmarkScreen(),
      ),
    );
  }

  Future toGoldSilverDetailScreen(
      BuildContext context, GoldSilverUIModel entity) {
    return GoldSilverDetailScreen.navigate(
        context: context, goldSilver: entity);
  }
}
