import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/ui/topics/topics/widgets/news_topic_list.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsTopicsScreen extends StatelessWidget {
  static Future navigate(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsTopicsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsProvider.topicBlocProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News Topics',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: const NewsTopicList(),
          ),
        ),
      ),
    );
  }
}
