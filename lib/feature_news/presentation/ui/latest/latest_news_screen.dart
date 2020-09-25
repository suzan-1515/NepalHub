import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/models/news_type.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/latest/widgets/latest_news_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestNewsScreen extends StatefulWidget {
  @override
  _LatestNewsScreenState createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<FeedBloc>().add(GetNewsEvent(newsType: NewsType.BREAKING));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
