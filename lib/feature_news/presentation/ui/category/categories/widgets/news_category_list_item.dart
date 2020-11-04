import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/events/feed_event.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';

class NewsCategoryListItem extends StatelessWidget {
  const NewsCategoryListItem({
    Key key,
    @required this.category,
  }) : super(key: key);

  final NewsCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          GetIt.I
              .get<NavigationService>()
              .toNewsCategoryFeedScreen(context, category);
        },
        leading: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                ),
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: CachedImage(
            category.icon,
            tag: category.code,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${category.followerCount.compactFormat} Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              FollowUnFollowButton(
                isFollowed: category.isFollowed,
                onTap: () {
                  if (category.isFollowed) {
                    GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                        data: category, eventType: 'category_unfollow'));
                    context
                        .bloc<CategoryFollowUnFollowBloc>()
                        .add(CategoryFollowEvent(category: category));
                  } else {
                    GetIt.I.get<EventBus>().fire(NewsChangeEvent(
                        data: category, eventType: 'category_follow'));
                    context
                        .bloc<CategoryFollowUnFollowBloc>()
                        .add(CategoryUnFollowEvent(category: category));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
