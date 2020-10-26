import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/widgets/news_source_feed_list.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_appbar.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsSourceFeedScreen extends StatelessWidget {
  final NewsSourceEntity newsSourceEntity;
  const NewsSourceFeedScreen({Key key, @required this.newsSourceEntity})
      : super(key: key);

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<FollowUnFollowBloc, FollowUnFollowState>(
      builder: (context, state) {
        final NewsSourceUIModel sourceUIModel =
            context.bloc<NewsSourceFeedBloc>().sourceModel;
        return NewsFilterHeader(
          icon: DecorationImage(
            image: sourceUIModel.source.isValidIcon
                ? AdvancedNetworkImage(sourceUIModel.source.icon)
                : AssetImage('assets/images/user.png'),
            fit: BoxFit.cover,
          ),
          title: sourceUIModel.source.title,
          isFollowed: sourceUIModel.source.isFollowed,
          onTap: () {
            if (sourceUIModel.source.isFollowed) {
              sourceUIModel.unfollow();
              context
                  .bloc<FollowUnFollowBloc>()
                  .add(FollowUnFollowUnFollowEvent());
            } else {
              sourceUIModel.follow();
              context
                  .bloc<FollowUnFollowBloc>()
                  .add(FollowUnFollowFollowEvent());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsProvider.sourceFeedBlocProvider(
      newsSourceUIModel: newsSourceEntity.toUIModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: NewsFilteringAppBar(
            header: _buildHeader(context),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewsSourceFeedList(),
            ),
          ),
        ),
      ),
    );
  }
}
