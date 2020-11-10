import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsSourceFeedHeader extends StatelessWidget {
  const NewsSourceFeedHeader();

  @override
  Widget build(BuildContext context) {
    final source =
        ScopedModel.of<NewsSourceUIModel>(context, rebuildOnChange: true);
    return NewsFilterHeader(
      icon: DecorationImage(
        image: source.entity.isValidIcon
            ? AdvancedNetworkImage(source.entity.icon)
            : AssetImage('assets/images/user.png'),
        fit: BoxFit.cover,
      ),
      title: source.entity.title,
      isFollowed: source.entity.isFollowed,
      onTap: () {
        if (source.entity.isFollowed) {
          source.unFollow();
          context
              .read<SourceFollowUnFollowBloc>()
              .add(SourceUnFollowEvent(source: source.entity));
        } else {
          source.follow();
          context
              .read<SourceFollowUnFollowBloc>()
              .add(SourceFollowEvent(source: source.entity));
        }
      },
    );
  }
}
