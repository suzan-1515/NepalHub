import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart'
    as sourceFollowUnfollow;
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSourceListItem extends StatelessWidget {
  const NewsSourceListItem({
    Key key,
    @required this.sourceUIModel,
  }) : super(key: key);

  final NewsSourceUIModel sourceUIModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          GetIt.I.get<NavigationService>().toNewsSourceFeedScreen(
              context: context, source: sourceUIModel.source);
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
            sourceUIModel.source.icon,
            tag: sourceUIModel.source.code,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sourceUIModel.source.title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<sourceFollowUnfollow.FollowUnFollowBloc,
              sourceFollowUnfollow.FollowUnFollowState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${sourceUIModel.formattedFollowerCount} Followers',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  FollowUnFollowButton(
                    isFollowed: sourceUIModel.source.isFollowed,
                    onTap: () {
                      if (sourceUIModel.source.isFollowed) {
                        sourceUIModel.unfollow();
                        context
                            .bloc<sourceFollowUnfollow.FollowUnFollowBloc>()
                            .add(sourceFollowUnfollow
                                .FollowUnFollowUnFollowEvent());
                      } else {
                        sourceUIModel.follow();
                        context
                            .bloc<sourceFollowUnfollow.FollowUnFollowBloc>()
                            .add(sourceFollowUnfollow
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
