import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/constants/app_constants.dart';
import 'package:samachar_hub/core/utils/date_time_utils.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/corona_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/date_weather_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/daily_horoscope_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/latest_news_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/news_category_menu_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/news_source_menu_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/news_topics_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/other_menu_section.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/trending_news_section.dart';

class HomeListBuilder extends StatelessWidget {
  final HomeEntity data;
  final Future<void> Function() onRefresh;
  final ScrollController scrollController;

  const HomeListBuilder(
      {Key key,
      @required this.data,
      @required this.onRefresh,
      @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            sliver: SliverAppBar(
              elevation: 0,
              forceElevated: false,
              backgroundColor: Theme.of(context).backgroundColor,
              title: RichText(
                  text: TextSpan(
                text: AppConstants.APP_NAME,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w800),
                children: [
                  if (user != null && !user.isAnonymous)
                    TextSpan(
                        text:
                            '\nGood ${timeContextGreeting()} ${user.fullname}',
                        style: Theme.of(context).textTheme.caption),
                ],
              )),
              pinned: false,
              floating: true,
            ),
          ),
          const SliverToBoxAdapter(child: const DateWeatherSection()),
          if (data.corona != null)
            SliverToBoxAdapter(
              child: CoronaSection(
                data: data.corona,
              ),
            ),
          if (isEarlyMorning() && data.horoscope != null)
            SliverToBoxAdapter(
                child: DailyHoroscope(
              data: data.horoscope,
            )),
          if (data.newsCategories != null && data.newsCategories.isNotEmpty)
            SliverToBoxAdapter(
                child: NewsCategoryMenuSection(
              newsCategories: data.newsCategories,
            )),
          if (data.trendingNews != null && data.trendingNews.isNotEmpty)
            SliverToBoxAdapter(
                child: TrendingNewsSection(
              trendingNews: data.trendingNews,
            )),
          if (data.newsTopics != null && data.newsTopics.isNotEmpty)
            SliverToBoxAdapter(
                child: NewsTopicsSection(
              items: data.newsTopics,
            )),

          // if (data.hasRecentNews)
          //   RecentNewsSection(
          //     recentNewsUIModel: data.recentNewsUIModel,
          //   ),
          if (data.forexe != null && data.goldSilver != null)
            SliverToBoxAdapter(
                child: OtherMenuSection(
              goldSilver: data.goldSilver,
              forex: data.forexe,
            )),
          if (data.newsSources != null && data.newsSources.isNotEmpty)
            SliverToBoxAdapter(
                child: NewsSourceMenuSection(newsSources: data.newsSources)),

          if (data.latestNews != null && data.latestNews.isNotEmpty)
            LatestNewsSection(
              latestNews: data.latestNews,
            ),
        ],
      ),
    );
  }
}
