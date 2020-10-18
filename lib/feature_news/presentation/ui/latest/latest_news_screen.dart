import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/latest/widgets/latest_news_list.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class LatestNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsProvider.feedBlocProvider(
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
