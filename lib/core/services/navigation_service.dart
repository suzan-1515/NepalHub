import 'package:corona_module/corona.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/login_screen.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_entity.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/main/main_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/settings_page.dart';
import 'package:samachar_hub/feature_news/domain/models/news_category.dart';
import 'package:samachar_hub/feature_news/domain/models/news_feed.dart';
import 'package:samachar_hub/feature_news/domain/models/news_source.dart';
import 'package:samachar_hub/feature_news/domain/models/news_topic.dart';
import 'package:samachar_hub/feature_news/presentation/ui/bookmark/bookmark_page.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/news_categories_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/category_feed/news_category_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/news_source_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/sources_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/news_topic_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/trending/trending_news_screen.dart';
import 'package:samachar_hub/feature_comment/presentation/ui/comment_screen.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail_screen.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/detail/horoscope_detail_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope_screen.dart';
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

  Future toCoronaScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoronaApp(),
      ),
    );
  }

  Future toForexScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForexScreen(),
      ),
    );
  }

  Future toForexDetailScreen(BuildContext context, ForexEntity data) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForexDetailScreen(
          forexEntity: data,
        ),
      ),
    );
  }

  Future toHoroscopeScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HoroscopeScreen(),
      ),
    );
  }

  Future toHoroscopeDetail(BuildContext context, String sign, String signIcon,
      String zodiac, HoroscopeEntity data) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HoroscopeDetailScreen(
          sign: sign,
          signIcon: signIcon,
          zodiac: zodiac,
          horoscopeEntity: data,
        ),
      ),
    );
  }

  Future toGoldSilverScreen(BuildContext context) {}

  Future toFeedDetail(NewsFeedEntity feedEntity, BuildContext context) {
    if (context.read<SettingsCubit>().settings.newsReadMode == 2) {
      return toWebViewScreen(feedEntity.title, feedEntity.link, context);
    }
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          feedEntity: feedEntity,
        ),
      ),
    );
  }

  Future toFollowedNewsSourceScreen(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsSourcesScreen(),
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
      {@required BuildContext context, @required NewsTopicEntity topicEntity}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsTopicFeedScreen(
          newsTopicEntity: topicEntity,
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
}
