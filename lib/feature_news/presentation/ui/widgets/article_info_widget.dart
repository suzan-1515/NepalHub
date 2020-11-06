import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_feed_entity.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_feed_more_option.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';

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
    @required this.feed,
  }) : super(key: key);

  final NewsFeedEntity feed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (feed.viewCount != 0)
          Text(
            '${feed.viewCount.compactFormat} views',
            style: Theme.of(context).textTheme.overline.copyWith(),
          ),
        if (feed.commentCount != 0)
          Text(
            ' • ${feed.commentCount.compactFormat} comments',
            style: Theme.of(context).textTheme.overline,
          ),
        if (feed.shareCount != 0)
          Text(
            ' • ${feed.shareCount.compactFormat} shares',
            style: Theme.of(context).textTheme.overline,
          ),
        Spacer(),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(
            FontAwesomeIcons.comment,
            size: 16,
          ),
          onPressed: () => GetIt.I.get<NavigationService>().toCommentsScreen(
              context: context,
              threadTitle: feed.title,
              threadId: feed.id,
              threadType: CommentThreadType.NEWS_FEED),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          icon: Icon(
            Icons.more_vert,
          ),
          onPressed: () => context.showBottomSheet(
              child: NewsFeedMoreOption(
            context: context,
            feed: feed,
          )),
        ),
      ],
    );
  }
}
