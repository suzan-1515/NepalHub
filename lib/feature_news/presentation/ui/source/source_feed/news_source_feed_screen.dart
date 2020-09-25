import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/widgets/news_source_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSourceFeedScreen extends StatefulWidget {
  const NewsSourceFeedScreen({Key key}) : super(key: key);
  @override
  _NewsSourceFeedScreenState createState() => _NewsSourceFeedScreenState();
}

class _NewsSourceFeedScreenState extends State<NewsSourceFeedScreen> {
  NewsSourceUIModel sourceUIModel;
  @override
  void initState() {
    super.initState();
    sourceUIModel = context.bloc<NewsSourceFeedBloc>().sourceModel;
  }

  Widget _buildHeader() {
    return BlocListener<FollowUnFollowBloc, FollowUnFollowState>(
      listener: (context, state) {
        if (state is FollowedState) {
          sourceUIModel.follow();
        } else if (state is UnFollowedState) {
          sourceUIModel.unfollow();
        }
      },
      child: NewsFilterHeader(
        icon: DecorationImage(
          image: AssetImage(sourceUIModel.source.isValidIcon
              ? sourceUIModel.source.icon
              : 'assets/images/user.png'),
          fit: BoxFit.cover,
        ),
        title: sourceUIModel.source.title,
        isFollowed: sourceUIModel.source.isFollowed,
        onTap: () {
          if (sourceUIModel.source.isFollowed) {
            sourceUIModel.unfollow();
            context
                .bloc<FollowUnFollowBloc>()
                .add(UnFollowEvent(sourceModel: sourceUIModel.source));
          } else {
            sourceUIModel.follow();
            context
                .bloc<FollowUnFollowBloc>()
                .add(FollowEvent(sourceModel: sourceUIModel.source));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: NewsFilteringAppBar(
          header: _buildHeader(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewsSourceFeedList(),
          ),
        ),
      ),
    );
  }
}
