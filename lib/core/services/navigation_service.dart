import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/login_screen.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/forex_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/details/gold_silver_detail_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/gold_silver_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/main/main_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/settings_page.dart';
import 'package:samachar_hub/feature_main/presentation/ui/splash/splash_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/bookmark/bookmark_page.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/news_categories_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/news_category_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen_preloader.dart';
import 'package:samachar_hub/feature_news/presentation/ui/latest/latest_news_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/news_source_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/sources_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topic_feed/news_topic_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/topics_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/trending/trending_news_screen.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/comment_screen.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail/forex_detail_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/detail/horoscope_detail_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope/horoscope_screen.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/user_profile_screen.dart';
import 'package:samachar_hub/core/widgets/webview_widget.dart';

class NavigationService {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(), settings: settings);
      case MainScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => MainScreen(), settings: settings);
      case LoginScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      case TrendingNewsScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => TrendingNewsScreen(), settings: settings);
      case LatestNewsScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => LatestNewsScreen(), settings: settings);
      case NewsDetailScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsDetailScreen(), settings: settings);
      case NewsDetailScreenPreloader.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsDetailScreenPreloader(), settings: settings);
      case ForexScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => ForexScreen(), settings: settings);
      case ForexDetailScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => ForexDetailScreen(), settings: settings);
      case HoroscopeScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => HoroscopeScreen(), settings: settings);
      case HoroscopeDetailScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => HoroscopeDetailScreen(), settings: settings);
      case GoldSilverScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => GoldSilverScreen(), settings: settings);
      case GoldSilverDetailScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => GoldSilverDetailScreen(), settings: settings);
      case NewsSourcesScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsSourcesScreen(), settings: settings);
      case NewsTopicsScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsTopicsScreen(), settings: settings);
      case NewsCategoryFeedScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsCategoryFeedScreen(), settings: settings);
      case NewsCategoriesScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsCategoriesScreen(), settings: settings);
      case NewsTopicFeedScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsTopicFeedScreen(), settings: settings);
      case NewsSourceFeedScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => NewsSourceFeedScreen(), settings: settings);
      case InBuiltWebViewScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => InBuiltWebViewScreen(), settings: settings);
      case CommentScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => CommentScreen(), settings: settings);
      case SettingsScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => SettingsScreen(), settings: settings);
      case UserProfileScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => UserProfileScreen(), settings: settings);
      case BookmarkScreen.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (_) => BookmarkScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ),
            settings: settings);
    }
  }
}
