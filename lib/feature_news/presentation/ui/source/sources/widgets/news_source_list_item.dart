import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/widgets/cached_image_widget.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_source/follow_unfollow/follow_un_follow_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_source.dart';
import 'package:samachar_hub/feature_news/presentation/ui/source/source_feed/news_source_feed_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/follow_unfollow_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsSourceListItem extends StatelessWidget {
  const NewsSourceListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final source =
        ScopedModel.of<NewsSourceUIModel>(context, rebuildOnChange: true);
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, NewsSourceFeedScreen.ROUTE_NAME,
              arguments: source);
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
            source.entity.icon,
            tag: source.entity.code,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            source.entity.title,
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
                '${source.entity.followerCount.compactFormat} Followers',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              FollowUnFollowButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
