import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/models/news_type.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_latest_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_recent_news_use_case.dart';
import 'package:samachar_hub/feature_news/domain/usecases/get_trending_news_use_case.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/latest/widgets/latest_news_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (context) => FeedBloc(
        latestNewsUseCase: context.repository<GetLatestNewsUseCase>(),
        recentNewsUseCase: context.repository<GetRecentNewsUseCase>(),
        trendingNewsUseCase: context.repository<GetTrendingNewsUseCase>(),
      )..add(GetNewsEvent(newsType: NewsType.LATEST)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Latest News',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: LatestNewsList(),
          ),
        ),
      ),
    );
  }
}
