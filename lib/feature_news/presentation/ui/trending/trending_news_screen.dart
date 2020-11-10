import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/presentation/ui/trending/widgets/trending_news_list.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({Key key}) : super(key: key);

  static Future navigate(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrendingNewsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsProvider.feedBlocProvider(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Trending News'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const TrendingNewsList(),
          ),
        ),
      ),
    );
  }
}
