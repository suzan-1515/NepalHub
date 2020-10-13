import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/models/news_type.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_latest_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_recent_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_trending_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/trending/widgets/trending_news_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (context) => FeedBloc(
        latestNewsUseCase: context.repository<GetLatestNewsUseCase>(),
        recentNewsUseCase: context.repository<GetRecentNewsUseCase>(),
        trendingNewsUseCase: context.repository<GetTrendingNewsUseCase>(),
      )..add(GetNewsEvent(newsType: NewsType.TRENDING)),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Trending News'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TrendingNewsList(),
          ),
        ),
      ),
    );
  }
}
