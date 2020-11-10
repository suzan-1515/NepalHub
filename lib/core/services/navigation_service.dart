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
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_topic.dart';
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
    return MainScreen.navigate(context);
  }

  Future toLoginScreen(BuildContext context) {
    return LoginScreen.navigate(context);
  }

  Future toTrendingNews(BuildContext context) {
    return TrendingNewsScreen.navigate(context);
  }

  Future toLatestNewsScreen(BuildContext context) {
    return LatestNewsScreen.navigate(context);
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
    return NewsSourcesScreen.navigate(context);
  }

  Future toFollowedNewsTopicScreen(BuildContext context) {
    return NewsTopicsScreen.navigate(context);
  }

  Future toNewsCategoryFeedScreen(
      BuildContext context, NewsCategoryUIModel categoryUIModel) {
    return NewsCategoryFeedScreen.navigate(context, categoryUIModel);
  }

  Future toFollowedNewsCategoryScreen(BuildContext context) {
    return NewsCategoriesScreen.navigate(context);
  }

  Future toWebViewScreen(String title, String url, BuildContext context) {
    return Webview.navigate(context, title, url);
  }

  Future toNewsTopicFeedScreen(
      {@required BuildContext context,
      @required NewsTopicUIModel topicUIModel}) {
    return NewsTopicFeedScreen.navigate(context, topicUIModel);
  }

  Future toNewsSourceFeedScreen(
      {@required NewsSourceUIModel sourceUIModel,
      @required BuildContext context}) {
    return NewsSourceFeedScreen.navigate(context, sourceUIModel);
  }

  Future toCommentsScreen(
      {@required BuildContext context,
      @required String threadTitle,
      @required CommentThreadType threadType,
      @required String threadId}) {
    return CommentScreen.navigate(context, threadId, threadType, threadTitle);
  }

  Future loginRedirect(BuildContext context) {
    return LoginScreen.navigate(context);
  }

  Future toSettingsScreen({@required BuildContext context}) {
    return SettingsScreen.navigate(context);
  }

  Future toUserProfileScreen({@required BuildContext context}) {
    return UserProfileScreen.navigate(context);
  }

  Future toBookmarkedNewsScreen({@required BuildContext context}) {
    return BookmarkScreen.navigate(context);
  }

  Future toGoldSilverDetailScreen(
      BuildContext context, GoldSilverUIModel entity) {
    return GoldSilverDetailScreen.navigate(
        context: context, goldSilver: entity);
  }
}
