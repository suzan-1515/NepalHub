import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/follow_unfollow/follow_un_follow_bloc.dart'
    as categoryFollowUnfollow;
import 'package:samachar_hub/feature_news/presentation/models/news_category.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';

class NewsCategoryListItem extends StatelessWidget {
  const NewsCategoryListItem({
    Key key,
    @required this.categoryUIModel,
  }) : super(key: key);

  final NewsCategoryUIModel categoryUIModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          GetIt.I
              .get<NavigationService>()
              .toNewsCategoryFeedScreen(context, categoryUIModel.category);
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
            categoryUIModel.category.icon,
            tag: categoryUIModel.category.code,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            categoryUIModel.category.title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<categoryFollowUnfollow.FollowUnFollowBloc,
              categoryFollowUnfollow.FollowUnFollowState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${categoryUIModel.formattedFollowerCount} Followers',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  FollowUnFollowButton(
                    isFollowed: categoryUIModel.category.isFollowed,
                    onTap: () {
                      if (categoryUIModel.category.isFollowed) {
                        categoryUIModel.unfollow();
                        context
                            .bloc<categoryFollowUnfollow.FollowUnFollowBloc>()
                            .add(categoryFollowUnfollow
                                .FollowUnFollowUnFollowEvent());
                      } else {
                        categoryUIModel.follow();
                        context
                            .bloc<categoryFollowUnfollow.FollowUnFollowBloc>()
                            .add(categoryFollowUnfollow
                                .FollowUnFollowFollowEvent());
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
