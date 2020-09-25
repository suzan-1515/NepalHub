import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart'
    as sourceFollowUnfollow;
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          context.repository<NavigationService>().toNewsSourceFeedScreen(
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
          child: CachedNetworkImage(
            imageUrl: sourceUIModel.source.icon,
            errorWidget: (context, url, error) => Opacity(
                opacity: 0.7, child: Icon(FontAwesomeIcons.exclamationCircle)),
            progressIndicatorBuilder: (context, url, progress) =>
                Center(child: CircularProgressIndicator()),
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
              if (state is sourceFollowUnfollow.FollowedState) {
                sourceUIModel.follow();
              } else if (state is sourceFollowUnfollow.UnFollowedState) {
                sourceUIModel.unfollow();
              }
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
                      final currentValue = sourceUIModel.source.isFollowed;
                      if (currentValue) {
                        sourceUIModel.unfollow();
                        context
                            .bloc<sourceFollowUnfollow.FollowUnFollowBloc>()
                            .add(sourceFollowUnfollow.UnFollowEvent(
                                sourceModel: sourceUIModel.source));
                      } else {
                        sourceUIModel.follow();
                        context
                            .bloc<sourceFollowUnfollow.FollowUnFollowBloc>()
                            .add(sourceFollowUnfollow.FollowEvent(
                                sourceModel: sourceUIModel.source));
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
