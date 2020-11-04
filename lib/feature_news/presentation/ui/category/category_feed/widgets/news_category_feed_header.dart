import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/category_feeds/news_category_feed_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_filter_header.dart';

class NewsCategoryFeedHeader extends StatelessWidget {
  const NewsCategoryFeedHeader();

  Widget _buildHeader(BuildContext context, NewsCategoryEntity category) {
    return NewsFilterHeader(
      icon: DecorationImage(
        image: category.isValidIcon
            ? AdvancedNetworkImage(category.icon)
            : AssetImage('assets/images/user.png'),
        fit: BoxFit.cover,
      ),
      title: category.title,
      isFollowed: category.isFollowed,
      onTap: () {
        if (category.isFollowed) {
          context
              .bloc<CategoryFollowUnFollowBloc>()
              .add(CategoryUnFollowEvent(category: category));
          GetIt.I.get<EventBus>().fire(
              NewsChangeEvent(data: category, eventType: 'category_unfollow'));
        } else {
          context
              .bloc<CategoryFollowUnFollowBloc>()
              .add(CategoryFollowEvent(category: category));
          GetIt.I.get<EventBus>().fire(
              NewsChangeEvent(data: category, eventType: 'category_follow'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryFollowUnFollowBloc, CategoryFollowUnFollowState>(
      buildWhen: (previous, current) =>
          (current is CategoryFollowInitialState) ||
          (current is CategoryFollowSuccessState) ||
          (current is CategoryUnFollowSuccessState),
      builder: (context, state) {
        if (state is CategoryFollowSuccessState) {
          return _buildHeader(context, state.category);
        } else if (state is CategoryUnFollowSuccessState) {
          return _buildHeader(context, state.category);
        }

        return _buildHeader(
            context, context.bloc<NewsCategoryFeedBloc>().category);
      },
    );
  }
}
