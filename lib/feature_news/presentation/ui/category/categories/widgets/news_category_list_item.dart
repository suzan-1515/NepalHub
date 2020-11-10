import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsCategoryListItem extends StatelessWidget {
  const NewsCategoryListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category =
        ScopedModel.of<NewsCategoryUIModel>(context, rebuildOnChange: true);
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
            category.entity.icon,
            tag: category.entity.code,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category.entity.title,
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
                '${category.entity.followerCount.compactFormat} Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              FollowUnFollowButton(
                isFollowed: category.entity.isFollowed,
                onTap: () {
                  if (category.entity.isFollowed) {
                    category.unFollow();
                    context
                        .read<CategoryFollowUnFollowBloc>()
                        .add(CategoryUnFollowEvent(category: category.entity));
                  } else {
                    category.follow();
                    context
                        .read<CategoryFollowUnFollowBloc>()
                        .add(CategoryFollowEvent(category: category.entity));
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
