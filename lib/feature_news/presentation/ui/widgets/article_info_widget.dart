import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/models/news_feed.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_feed_more_option.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsFeedCardSourceCategory extends StatelessWidget {
  final String sourceIcon;
  final String source;
  final String publishedDate;
  final String category;

  const NewsFeedCardSourceCategory({
    @required this.sourceIcon,
    @required this.source,
    @required this.publishedDate,
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: sourceIcon,
            placeholder: (context, _) => Icon(FontAwesomeIcons.image),
            errorWidget: (context, url, error) => Icon(FontAwesomeIcons.image),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        RichText(
          text: TextSpan(
            text: source,
            style: Theme.of(context).textTheme.subtitle2,
            children: <TextSpan>[
              TextSpan(
                  text: '\n$publishedDate',
                  style: Theme.of(context).textTheme.caption)
            ],
          ),
        ),
        Spacer(),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(12)),
          child: Text(
            category,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}

class NewsFeedCardTitleDescription extends StatelessWidget {
  final String title;
  final String description;
  final int descriptionMaxLines;

  const NewsFeedCardTitleDescription({
    @required this.title,
    @required this.description,
    this.descriptionMaxLines = 2,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          description ?? '',
          maxLines: descriptionMaxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1.copyWith(height: 1.3),
        ),
      ],
    );
  }
}

class NewsFeedOptions extends StatelessWidget {
  const NewsFeedOptions({
    Key key,
    @required this.feedUIModel,
  }) : super(key: key);

  final NewsFeedUIModel feedUIModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: 0.6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
            builder: (context, state) {
              return FlatButton.icon(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(
                  feedUIModel.feedEntity.likeCount == 0
                      ? 'Like'
                      : '${feedUIModel.formattedLikeCount}',
                  style: Theme.of(context).textTheme.overline,
                ),
                icon: state is InProgressState
                    ? Icon(
                        Icons.donut_large,
                        size: 16,
                        color: Theme.of(context).accentColor,
                      )
                    : feedUIModel.feedEntity.isLiked
                        ? Icon(
                            FontAwesomeIcons.solidThumbsUp,
                            size: 16,
                            color: Theme.of(context).accentColor,
                          )
                        : Icon(
                            FontAwesomeIcons.thumbsUp,
                            size: 16,
                          ),
                onPressed: () {
                  if (feedUIModel.feedEntity.isLiked) {
                    feedUIModel.unlike();
                    context.bloc<LikeUnlikeBloc>().add(UnlikeEvent());
                  } else {
                    feedUIModel.like();
                    context.bloc<LikeUnlikeBloc>().add(LikeEvent());
                  }
                },
              );
            },
          ),
          FlatButton.icon(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: Text(
              feedUIModel.feedEntity.commentCount == 0
                  ? 'Comment'
                  : '${feedUIModel.formattedCommentCount}',
              style: Theme.of(context).textTheme.overline,
            ),
            icon: Icon(
              FontAwesomeIcons.comment,
              size: 16,
            ),
            onPressed: () => context
                .repository<NavigationService>()
                .toCommentsScreen(
                    context: context,
                    threadTitle: feedUIModel.feedEntity.title,
                    threadId: feedUIModel.feedEntity.id,
                    threadType: CommentThreadType.NEWS_FEED),
          ),
          Spacer(),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () => context.showBottomSheet(
                child: NewsFeedMoreOption(
              feed: feedUIModel,
            )),
          ),
        ],
      ),
    );
  }
}
