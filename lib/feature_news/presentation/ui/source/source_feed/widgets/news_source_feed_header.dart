import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_source_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/source_feeds/news_source_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';

class NewsSourceFeedHeader extends StatelessWidget {
  const NewsSourceFeedHeader();

  Widget _buildHeader(BuildContext context, NewsSourceEntity source) {
    return NewsFilterHeader(
      icon: DecorationImage(
        image: source.isValidIcon
            ? AdvancedNetworkImage(source.icon)
            : AssetImage('assets/images/user.png'),
        fit: BoxFit.cover,
      ),
      title: source.title,
      isFollowed: source.isFollowed,
      onTap: () {
        if (source.isFollowed) {
          context
              .bloc<SourceFollowUnFollowBloc>()
              .add(SourceUnFollowEvent(source: source));
          GetIt.I.get<EventBus>().fire(
              NewsChangeEvent(data: source, eventType: 'source_unfollow'));
        } else {
          context
              .bloc<SourceFollowUnFollowBloc>()
              .add(SourceFollowEvent(source: source));
          GetIt.I
              .get<EventBus>()
              .fire(NewsChangeEvent(data: source, eventType: 'source_follow'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceFollowUnFollowBloc, SourceFollowUnFollowState>(
      buildWhen: (previous, current) =>
          (current is SourceFollowInitialState) ||
          (current is SourceFollowSuccessState) ||
          (current is SourceUnFollowSuccessState),
      builder: (context, state) {
        if (state is SourceFollowSuccessState) {
          return _buildHeader(context, state.source);
        } else if (state is SourceUnFollowSuccessState) {
          return _buildHeader(context, state.source);
        }

        return _buildHeader(context, context.bloc<NewsSourceFeedBloc>().source);
      },
    );
  }
}
