import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/domain/models/news_type.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/feed_bloc/feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/trending/widgets/trending_news_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingNewsScreen extends StatefulWidget {
  const TrendingNewsScreen({Key key}) : super(key: key);
  @override
  _TrendingNewsScreenState createState() => _TrendingNewsScreenState();
}

class _TrendingNewsScreenState extends State<TrendingNewsScreen> {
  // Reaction disposers

  @override
  void initState() {
    super.initState();
    context.bloc<FeedBloc>().add(GetNewsEvent(newsType: NewsType.TRENDING));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
