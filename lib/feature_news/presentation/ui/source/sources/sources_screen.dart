import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/sources/widgets/news_source_list.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsSourcesScreen extends StatelessWidget {
  static Future navigate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsSourcesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsProvider.sourceBlocProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News Sources',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: const NewsSourceList(),
          ),
        ),
      ),
    );
  }
}
